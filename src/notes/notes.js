const e = require("express");
const Joi = require("joi");
const LoggerInstance = require("../../logger");
const { verifyToken } = require("../../shared/token");
const notes = require("../models/note");
const user = require("../models/user");

const addNote = async (req,res) => {
    try{
        const token = req.headers.authorization;
        if(token === undefined){
            throw {
                status: 409,
                message: 'Auth Failed'
            }
        }
        const decoded = verifyToken(token.slice(7, token.length).trimLeft());
        const schema = Joi.object({
            title: Joi.string().required(),
            subtitle: Joi.string().required()
        });
        const options = {
            abortEarly: false,
            allowUnknown: true,
            stripUnknown: true,
          };
        const { value , error } = schema.validate(req.body,options);
        if(error){
            LoggerInstance.warn(error);
            throw{
                status: 422,
                message: 'Validation Error'+error.details.map((val) => val.message).join(","),
            }
        }
        else{
            LoggerInstance.info(decoded.id)
            value.userId = decoded.id;
            await notes.create(value);
            res.status(201).json({
                message: 'Note Added'
            })
        }
    }catch(e){
        LoggerInstance.warn(e)
        res.status(e.status || 500).json({
            message: e.message || 'An unexpected error occurred'
        })
    }
}

const getNotes = async (req,res) => {
    try{
        const token = req.headers.authorization;
        if(token === undefined){
            throw {
                status: 409,
                message: 'Auth Failed'
            }
        }
        const decoded = verifyToken(token.slice(7, token.length).trimLeft());
        const userDoc = await user.findById(decoded.id);
        LoggerInstance.info(userDoc);
        const result = await notes.find({userId: decoded.id});
        const sharedResult = await notes.find({sharedWith: `${userDoc.email}`});
        res.status(200).json({
            message:'Query Complete',
            notes: result.concat(sharedResult)
        })
    }catch(e){
        LoggerInstance.warn(e)
        res.status(e.status || 500).json({
            message: e.message || 'An unexpected error occurred'
        })
    }
}

const shareNote = async (req,res) => {
    try{
        const token = req.headers.authorization;
        if(token === undefined){
            throw {
                status: 409,
                message: 'Auth Failed'
            }
        }
        const decoded = verifyToken(token.slice(7, token.length).trimLeft());
        const schema = Joi.object({
            emails: Joi.array().items(Joi.string().email()).required(),
            id: Joi.string().required()
        });
        const options = {
            abortEarly: false,
            allowUnknown: true,
            stripUnknown: true,
          };
          const {value , error} = schema.validate(req.body, options);
          if(error){
            LoggerInstance.warn(error);
            throw{
                status: 422,
                message: 'Validation Error'+error.details.map((val) => val.message).join(","),
            }
          }
          else{
              const userPersonalDoc = await user.findById(decoded.id);
              const noteData = await notes.findById(value.id);
              const finalEmails = noteData.sharedWith;
              for(let email of value.emails){
                  LoggerInstance.info(email)
                  if(email === userPersonalDoc.email || finalEmails.includes(email)){
                      continue;
                  }
                const userDoc = await user.findOne({email: email});
                if(userDoc !== null){
                    finalEmails.push(email);
                }
              }
              LoggerInstance.info(finalEmails);
              await notes.findByIdAndUpdate(value.id, {
                  $set : { sharedWith: finalEmails , isShared: true},
              })
              res.status(200).json({
                  message: 'Sharing...'
              })
          }
    }
    catch(e){
        LoggerInstance.warn(e)
        res.status(e.status || 500).json({
            message: e.message || 'An unexpected error occurred'
        })
    }
}

module.exports = {
    addNote: addNote,
    getNotes: getNotes,
    shareNote: shareNote
}
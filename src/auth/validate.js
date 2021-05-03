const Joi = require('joi');
const {verifyToken} = require('../../shared/token');
const user = require('../models/user');
const validateToken = (req,res) => {
    try{
        const schema = Joi.object({
            token: Joi.string().required()
        });
        const options = {
            abortEarly: false,
            allowUnknown: true,
            stripUnknown: true,
          };
        const {value,error} = schema.validate(req.body,options);
        if(error){
            throw {
                message: 'Validation Error',
                status: 422
            }
        }else{
            const decoded = verifyToken(value.token);
            const userDoc = user.findById(decoded.id);
            if(userDoc !== null){
                res.status(200).json({
                    message: true
                })
            }
            else{
                res.status(404).json({
                    message: false
                })
            }
        }
    }
    catch(e){
        res.status(e.status || 500).json({
            message: e.message || 'An unexpected error occurred'
        })
    }
}

module.exports = validateToken;
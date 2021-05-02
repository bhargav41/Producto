const Joi = require("joi");
const LoggerInstance = require("../../logger");
const { verifyPassword } = require("../../shared/password");
const { generateToken } = require("../../shared/token");
const user = require("../models/user");

const login = async (req, res) => {
  try {
    const Schema = Joi.object({
      email: Joi.string()
        .regex(
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        )
        .required(),
      password: Joi.string().min(6).max(12).required(),
    });

    const options = {
      abortEarly: false,
      allowUnknown: true,
      stripUnknown: true,
    };
    const { value, error } = Schema.validate(req.body , options);
    if (error) {
      LoggerInstance.error(error);
      throw {
        message:
          "Validation Error. " +
          error.details.map((val) => val.message).join(","),
        status: 422,
      };
    } else {
      const userDoc = await user.findOne({
        email: value.email,
      });
      if (userDoc !== null) {
        if (verifyPassword(value.password, userDoc.password)) {
          const token = generateToken({ id: userDoc.id });
          res.status(200).json({
            message: "User Created",
            token: token,
          });
          return;
        } else {
            throw {
                message: 'Credentials Incorrect',
                status: 409
            }
        }
      } else {
        throw {
          message: "User not found",
          status: 404,
        };
      }
    }
  } catch (e) {
      LoggerInstance.error(e)
    res.status(e.status || 500).json({
      message: e.message || "An unexpected error occurred",
    });
  }
};

module.exports = login;

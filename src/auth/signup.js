const Joi = require("joi");
const LoggerInstance = require("../../logger");
const { hashPassword } = require("../../shared/password");
const { generateToken } = require("../../shared/token");
const user = require("../models/user");

const signup = async (req, res) => {
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
    const { value, error } = Schema.validate(req.body, options);
    if (error) {
      LoggerInstance.error(error);
      throw {
        message:
          "Validation Error. " +
          error.details.map((val) => val.message).join(","),
        status: 422,
      };
    } else {
      const userData = await user.findOne({ email: value.email });
      if (userData !== null) {
        LoggerInstance.warn(userData);
        throw {
          message: "User Already Exists",
          status: 409
        };
      }
      const userDoc = await user.create({
        email: value.email,
        password: hashPassword(value.password),
      });
      const token = generateToken({ id: userDoc.id });
      res.status(200).json({
        message: "User Created",
        token: token,
      });
      return;
    }
  } catch (e) {
    res.status(e.status || 500).json({
      message: e.message || "An unexpected error occurred",
    });
  }
};

module.exports = signup;

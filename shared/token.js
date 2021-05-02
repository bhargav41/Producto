const jwt = require("jsonwebtoken");
const config = require("../config");
const generateToken = (payload) => jwt.sign(payload, config.secret, { expiresIn: config.expiresIn });
const verifyToken = (token) => jwt.verify(token, config.secret);

module.exports = {
    generateToken: generateToken,
    verifyToken: verifyToken
};

const bcrypt = require('bcrypt');
const config = require('../config');

const hashPassword = (password) => {
    const salt = bcrypt.genSaltSync(config.saltRounds);
    const hashedPassword = bcrypt.hashSync(password , salt);
    return hashedPassword;
}

const verifyPassword = (password , hashed) => {
    return bcrypt.compareSync(password , hashed);
}

module.exports = {
    hashPassword: hashPassword,
    verifyPassword: verifyPassword
};
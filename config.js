const dotenv = require('dotenv');

dotenv.config();

const config = {
  uri: process.env.MONGO_URI,
  secret: process.env.JWT_SECRET,
  expiresIn: '30d',
  saltRounds: parseInt(process.env.SALT_ROUNDS),
  logs: {
    level: process.env.LOG_LEVEL || 'silly',
  },
};

module.exports = config;

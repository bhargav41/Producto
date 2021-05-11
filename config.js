const dotenv = require("dotenv");

dotenv.config();

const config = {
  uri: process.env.MONGO_URI,
  secret: process.env.JWT_SECRET,
  expiresIn: "30d",
  saltRounds: parseInt(process.env.SALT_ROUNDS),
  apiKey: process.env.API_KEY,
  domain: process.env.DOMAIN,
  logs: {
    level: process.env.LOG_LEVEL || "silly",
  },
};

module.exports = config;

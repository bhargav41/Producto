const mongoose = require('mongoose');
const userSchema = mongoose.Schema({
    email: {type: String , required: true},
    password: {type: String, required: true},
    date: {type: String, default: Date.now(), timestamp: true}
})

const user = mongoose.model('user' , userSchema);

module.exports = user;
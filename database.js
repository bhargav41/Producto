const mongoose = require('mongoose');
const config = require('./config');

let db;

async function initializeClient(){
    let conn = await mongoose.connect(config.uri, {useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true, useFindAndModify: false});
    return conn;
}

module.exports = async () => {
    if(!db){
        db = await initializeClient();
    }
    return db;
}
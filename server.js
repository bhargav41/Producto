const express = require('express');

const helmet = require('helmet');
const cors = require('cors');
const LoggerInstance = require('./logger');
const database = require('./database');

const app = express();

const port = process.env.PORT || 8000;

app.use(helmet());
app.use(cors());

app.use(express.json());
app.use(express.urlencoded({extended: true}))

const authRouter = require('./src/auth/router');

app.use('/auth', authRouter);

app.get('/' , (req,res) => {
    res.status(200).json({
        message: 'Server Started'
    });
});

app.use('*' , (req , res) => {
    res.status(404).json({
        message: 'Route Not Found'
    })
})

app.listen(port , (err) => {
    if(err) {
        LoggerInstance.error(err);
    }
    else{
        database().then((val) => {
            LoggerInstance.info('Server Started');
        }).catch((e) => {
            LoggerInstance.error(e);
        })
    }
})
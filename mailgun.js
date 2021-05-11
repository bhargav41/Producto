const config = require('./config');

const mailgun = require('mailgun-js')({apiKey: config.apiKey , domain: config.domain});

const data = (email , subject , content) => {
    return {
        from: `Team Tech Analogy <notes@${config.domain}>`,
        to: `${email}`,
        subject: `${subject}`,
        html: `${content}`,
        'o:tag':['share']
    }
}

module.exports = (email , subject , content) => {
    mailgun.messages().send(data(email , subject , content) , (error , body) => {
        if(error){
            console.error(`Error : ${error}`);
        }
        else{
            console.info(`Response : ${body}`);
        }
    })
}


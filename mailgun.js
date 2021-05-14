const config = require('./config');

const mailgun = require('mailgun-js')({apiKey: config.apiKey , domain: config.domain});

const data = (emails , subject , content) => {
    return {
        from: `Team Producto <notes@${config.domain}>`,
        to: `${emails.map((val) => val).join(",")}`,
        subject: `${subject}`,
        html: `${content}`,
        'o:tag':[`share ${subject}`]
    }
}

module.exports = (emails , subject , content) => {
    mailgun.messages().send(data(emails , subject , content) , (error , body) => {
        if(error){
            console.error(`Error : ${error}`);
        }
        else{
            console.info(`Response : ${body}`);
        }
    })
}


var config = require('../config.json');
var AWS = require('aws-sdk');
  var winston = require('winston');
  require('winston-daily-rotate-file');
var fs = require('fs');
var dir = './log';

if (!fs.existsSync(dir)){
    fs.mkdirSync(dir);
}
  var transport = new winston.transports.DailyRotateFile({
    filename: './log/log',
    datePattern: 'yyyy-MM-dd.',
    prepend: true,
    level: process.env.ENV === 'development' ? 'debug' : 'info'
  });

  var logger = new (winston.Logger)({
    transports: [
      transport
    ]
  });

  //logger.info('Hello World!');

module.exports = {
log: function (message) {
   logger.info(message);
},

sendSMS: function(number,message,func_callback){
    AWS.config.update({
        accessKeyId: config.accessKeyId,
        secretAccessKey: config.secretAccessKey,
        region: config.region
    });

    var sns = new AWS.SNS();
var params = {
  Message: message, 

  PhoneNumber: number
  

};
sns.publish(params, function(err, data) {

  return func_callback(err != null);           // successful response
});


}




};
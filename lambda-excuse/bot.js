var bot = require('claudia-bot-builder'),
    excuse = require('huh');

module.exports = bot(funciton (req) {
    return "We've recieved your message: " + req.text +
        ". Your concern is important to us, however " +
        excuse.get();
});

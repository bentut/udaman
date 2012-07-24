// phantom.casperPath = '/Users/bentrevino/casperjs';
// phantom.injectJs(phantom.casperPath + '/bin/bootstrap.js');

var casper = require('casper').create();

casper.start('http://s9n53.soc.hawaii.edu:3000/users/sign_in', function() {
	console.log("starting");
    this.fill('form#user_new', {
        'user[email]':    'btrevino@hawaii.edu',
        'user[password]':    '331Clipper',
    }, true);
});

casper.then(function() {
    this.evaluateOrDie(function() {
        return /month/.test(document.body.innerText);
    }, 'logging in failed');
});

casper.thenOpen("http://s9n53.soc.hawaii.edu:3000/investigate_visual", function(){
	console.log("opening investigate visual");
	this.captureSelector('investigate_visual.png', 'body');
	//console.log(this.captureBase64('png'));
});

casper.run();// function() {
// 	console.log("running");
// 	phantom.exit();
// });



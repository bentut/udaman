// phantom.casperPath = '/Users/bentrevino/casperjs';
// phantom.injectJs(phantom.casperPath + '/bin/bootstrap.js');

var casper = require('casper').create();

casper.start('http://www.uhero.hawaii.edu/123/unemployment-rates-in-hawaii-seasonally-adjusted', function() {
	console.log("starting");
	this.captureSelector('google_chart.png', '#chart2');
	console.log("ending");
});
// 
// casper.then(function() {
//     this.evaluateOrDie(function() {
//         return /month/.test(document.body.innerText);
//     }, 'logging in failed');
// });
// 
// casper.thenOpen("http://s199n112.soc.hawaii.edu:3000/investigate_visual", function(){
// 	console.log("opening investigate visual");
// 	this.captureSelector('investigate_visual.png', 'body');
// 	//console.log(this.captureBase64('png'));
// });

casper.run();// function() {
// 	console.log("running");
// 	phantom.exit();
// });

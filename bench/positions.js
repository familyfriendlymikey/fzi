
/*body*/
const p = console.log;

let fzi = require('../main.js');

let needle = "p";

let haystack = "I would like to eat some food please!";

for (let _ = 0; _ <= 500000; _++) {
	
	fzi.replaceMatchedRanges(needle,haystack,function(_0) { return ("<span>" + _0 + "</span>"); });
};

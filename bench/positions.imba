const p = console.log

let fzi = require '../main.js'

let needle = "p"

let haystack = "I would like to eat some food please!"

for _ in [0 .. 500000]
	fzi.replaceMatchedRanges(needle, haystack) do "<span>{$1}</span>"

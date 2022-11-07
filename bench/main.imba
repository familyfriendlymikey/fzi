const p = console.log

const fzi = require '../main.js'
const { performance } = require 'perf_hooks'

import { replaceMatchesDiff } from './variations'
fzi.replaceMatchesDiff = replaceMatchesDiff

def bench name
	let iterations = 300_000
	let callback = $3
	if typeof $2 is 'number'
		iterations = $2
	else
		callback = $2
	p "{name} {iterations}"
	let startTime = performance.now!
	for _ in [0 .. iterations]
		callback!
	p performance.now! - startTime

let haystack = "I would like to eat some food please please please please please please please please please please please please!!!!!!!"
let wrap = do "<span>{$1}</span>"
let shortNeedle = "f"
let longNeedle = "would like to eat some food please please please please please please please please please please please please"

bench 'positions shortNeedle', do
	fzi.positions shortNeedle, haystack

bench 'replaceMatches shortNeedle', do
	fzi.replaceMatches shortNeedle, haystack, wrap

bench 'replaceMatchedRanges shortNeedle', do
	fzi.replaceMatchedRanges shortNeedle, haystack, wrap

bench 'replaceMatchesDiff shortNeedle', do
	fzi.replaceMatchesDiff shortNeedle, haystack, wrap

p!

bench 'positions longNeedle', 10_000, do
	fzi.positions longNeedle, haystack

bench 'replaceMatches longNeedle', 10_000, do
	fzi.replaceMatches longNeedle, haystack, wrap

bench 'replaceMatchedRanges longNeedle', 10_000, do
	fzi.replaceMatchedRanges longNeedle, haystack, wrap

bench 'replaceMatchesDiff longNeedle', 10_000, do
	fzi.replaceMatchesDiff longNeedle, haystack, wrap


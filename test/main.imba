let p = console.log

import fzi from '../main'

def expect a, cmp, b
	unless cmp a, b
		p "\n\nExpected:"
		p b
		p "\nReceived:"
		p a
		throw 1

def main
	await require('./score').default(expect, fzi)
	await require('./search').default(expect, fzi)
	await require('./positions').default(expect, fzi)
	await require('./replaceMatches').default(expect, fzi)
	await require('./replaceMatchedRanges').default(expect, fzi)
main!

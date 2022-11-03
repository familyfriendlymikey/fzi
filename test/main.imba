let p = console.log

import fzi from '../main'

def expect a, cmp, b
	unless cmp a, b
		p("\n\nA:") and p(a)
		p("\nB:") and p(b)
		p("\nCMP:") and p(cmp)
		throw ''

def main
	await require('./score').default(expect, fzi)
	await require('./search').default(expect, fzi)
	await require('./positions').default(expect, fzi)
main!

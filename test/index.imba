let p = console.log

import fzi from '..'

def expect a, cmp, b
	unless cmp a, b
		p("\n\nA:") and p(a)
		p("\nB:") and p(b)
		p("\nCMP:") and p(cmp)
		throw ''

def main
	await require('./score').default(expect, fzi)
	await require('./filter_sort').default(expect, fzi)
main!

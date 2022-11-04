const p = console.log

import { isEqual } from 'lodash'

let test = require('baretest')('replace')

let replace = do "<span>{$1}</span>"

export default do |expect, fzi|

	test("replace_consecutive") do
		let a = fzi.replaceMatches("amo", "app/models/foo", replace)
		# let b = ["<span>a</span>","p","p","/","<span>m</span>","<span>o</span>","d","e","l","s","/","f","o","o"]
		let b = '<span>a</span>pp/<span>m</span><span>o</span>dels/foo'
		expect a, isEqual, b

	test("replace_start_of_word") do
		let a = fzi.replaceMatches("amor", "app/models/order", replace)
		# let b = ["<span>a</span>","p","p","/","<span>m</span>","o","d","e","l","s","/","<span>o</span>","<span>r</span>","d","e","r"]
		let b = '<span>a</span>pp/<span>m</span>odels/<span>o</span><span>r</span>der'
		expect a, isEqual, b

	test("replace_no_bonuses") do
		let a = fzi.replaceMatches("as", "tags", replace)
		# let b = ["t","<span>a</span>","g","<span>s</span>"]
		let b = 't<span>a</span>g<span>s</span>'
		expect a, isEqual, b

	test("replace_no_bonuses_2") do
		let a = fzi.replaceMatches("as", "examples.txt", replace)
		# let b = ["e","x","<span>a</span>","m","p","l","e","<span>s</span>",".","t","x","t"]
		let b = 'ex<span>a</span>mple<span>s</span>.txt'
		expect a, isEqual, b

	test("replace_multiple_candidates_start_of_words") do
		let a = fzi.replaceMatches("abc", "a/a/b/c/c", replace)
		# let b = ["a","/","<span>a</span>","/","<span>b</span>","/","<span>c</span>","/","c"]
		let b = 'a/<span>a</span>/<span>b</span>/<span>c</span>/c'
		expect a, isEqual, b

	test("replace_exact_match") do
		let a = fzi.replaceMatches("foo", "foo", replace)
		# let b = ["<span>f</span>","<span>o</span>","<span>o</span>"]
		let b = '<span>f</span><span>o</span><span>o</span>'
		expect a, isEqual, b

	test.run!

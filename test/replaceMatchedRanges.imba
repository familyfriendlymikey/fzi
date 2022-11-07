const p = console.log

import { isEqual } from 'lodash'

let test = require('baretest')('replaceMatchedRanges')

let replace = do "<span>{$1}</span>"

export default do |expect, fzi|

	test("replace_consecutive") do
		let a = fzi.replaceMatchedRanges("amo", "app/models/foo", replace)
		let b = '<span>a</span>pp/<span>mo</span>dels/foo'
		expect a, isEqual, b

	test("replace_start_of_word") do
		let a = fzi.replaceMatchedRanges("amor", "app/models/order", replace)
		let b = '<span>a</span>pp/<span>m</span>odels/<span>or</span>der'
		expect a, isEqual, b

	test("replace_no_bonuses") do
		let a = fzi.replaceMatchedRanges("as", "tags", replace)
		let b = 't<span>a</span>g<span>s</span>'
		expect a, isEqual, b

	test("replace_no_bonuses_2") do
		let a = fzi.replaceMatchedRanges("as", "examples.txt", replace)
		let b = 'ex<span>a</span>mple<span>s</span>.txt'
		expect a, isEqual, b

	test("replace_multiple_candidates_start_of_words") do
		let a = fzi.replaceMatchedRanges("abc", "a/a/b/c/c", replace)
		let b = 'a/<span>a</span>/<span>b</span>/<span>c</span>/c'
		expect a, isEqual, b

	test("replace_exact_match") do
		let a = fzi.replaceMatchedRanges("foo", "foo", replace)
		let b = '<span>foo</span>'
		expect a, isEqual, b

	test("replace_start_all") do
		let a = fzi.replaceMatchedRanges("he", "hehe", replace)
		let b = '<span>he</span>he'
		expect a, isEqual, b

	test("more") do
		let a = fzi.replaceMatchedRanges("her", "Style a Hero", replace)
		let b = 'Style a <span>Her</span>o'
		expect a, isEqual, b

	test("more") do
		let a = fzi.replaceMatchedRanges("requests-headers", "Requests - Headers", replace)
		let b = '<span>Requests</span> <span>-</span> <span>Headers</span>'
		expect a, isEqual, b

	test.run!

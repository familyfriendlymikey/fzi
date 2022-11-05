import { isEqual } from 'lodash'

let test = require('baretest')('positions')

export default do |expect, fzi|

	test("positions_consecutive") do
		let a = fzi.positions("amo", "app/models/foo")
		let b = [0,4,5]
		expect a, isEqual, b

	test("positions_start_of_word") do
		let a = fzi.positions("amor", "app/models/order")
		let b = [0,4,11,12]
		expect a, isEqual, b

	test("positions_no_bonuses") do
		let a = fzi.positions("as", "tags")
		let b = [1,3]
		expect a, isEqual, b

	test("positions_no_bonuses_2") do
		let a = fzi.positions("as", "examples.txt")
		let b = [2,7]
		expect a, isEqual, b

	test("positions_multiple_candidates_start_of_words") do
		let a = fzi.positions("abc", "a/a/b/c/c")
		let b = [2,4,6]
		expect a, isEqual, b

	test("positions_exact_match") do
		let a = fzi.positions("foo", "foo")
		let b = [0,1,2]
		expect a, isEqual, b

	test("positions_all_start") do
		let a = fzi.positions("he", "hehehehehehehehehehehehe")
		let b = [0,1]
		expect a, isEqual, b

	test.run!

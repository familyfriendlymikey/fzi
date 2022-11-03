import { isEqual, eq, gt, lt } from 'lodash'

let test = require('baretest')('search')

export default do |expect, fzi|

	test("search empty string array") do
		let l = []
		let a = fzi.search "test", l
		let b = []
		expect a, isEqual, b

	test("search string array with single element") do
		let l = ["hello"]
		let a = fzi.search "h", l
		let b = ["hello"]
		expect a, isEqual, b

	test("search string array with single element") do
		let l = ["hello"]
		let a = fzi.search "test", l
		let b = []
		expect a, isEqual, b

	test("search empty object array") do
		let l = []
		let a = fzi.search "test", l, do |x| x.name
		let b = []
		expect a, isEqual, b

	test("search object array with single element") do
		let l = [{ name: "hello" }]
		let a = fzi.search "h", l, do |x| x.name
		let b = [{ name: "hello" }]
		expect a, isEqual, b

	test("search object array with single element") do
		let l = [{ name: "hello" }]
		let a = fzi.search "test", l, do |x| x.name
		let b = []
		expect a, isEqual, b

	test("search strings") do
		let l = ["hello", "world", "heck", "haha", "hoote"]
		let a = fzi.search "he", l
		let b = ["heck", "hello", "hoote"]
		expect a, isEqual, b

	test("search strings capital") do
		let a = ["a", "aa", "aA", "AA"]
		let b = fzi.search "a", a
		expect a, isEqual, b

	test("search objects") do
		let l = [
			{ name: "hello" }
			{ name: "world" }
			{ name: "heck" }
			{ name: "haha" }
			{ name: "hoote" }
		]
		let a = fzi.search("he", l) do |x| x.name
		let b = [
			{ name: "heck" }
			{ name: "hello" }
			{ name: "hoote" }
		]
		expect a, isEqual, b

	test.run!

import { isEqual, eq, gt, lt } from 'lodash'

let test = require('baretest')('sort')

export default do |expect, fzi|

	test("sort empty string array") do
		let l = []
		let a = fzi.sort "test", l
		let b = []
		expect a, isEqual, b

	test("sort string array with single element") do
		let l = ["hello"]
		let a = fzi.sort "h", l
		let b = ["hello"]
		expect a, isEqual, b

	test("sort string array with single element") do
		let l = ["hello"]
		let a = fzi.sort "test", l
		let b = ["hello"]
		expect a, isEqual, b

	test("sort string array with two elements") do
		let l = ["hello, test"]
		let a = fzi.sort "test", l
		let b = ["test, hello"]
		expect a, isEqual, b

	test("sort string array with three elements") do
		let l = ["t, hello, test"]
		let a = fzi.sort "test", l
		let b = ["test, t, hello"]
		expect a, isEqual, b

	test("sort empty object array") do
		let l = []
		let a = fzi.sort "test", l, do |x| x.name
		let b = []
		expect a, isEqual, b

	test("sort object array with single element") do
		let l = [{ name: "hello" }]
		let a = fzi.sort "h", l, do |x| x.name
		let b = [{ name: "hello" }]
		expect a, isEqual, b

	test("sort object array with single element") do
		let l = [{ name: "hello" }]
		let a = fzi.sort "test", l, do |x| x.name
		let b = []
		expect a, isEqual, b

	test("sort strings") do
		let l = ["hello", "world", "heck", "haha", "hoote"]
		let a = fzi.sort "he", l
		let b = ["heck", "hello", "hoote"]
		expect a, isEqual, b

	test("sort strings capital") do
		let a = ["a", "aa", "aA", "AA"]
		let b = fzi.sort "a", a
		expect a, isEqual, b

	test("sort objects") do
		let l = [
			{ name: "hello" }
			{ name: "world" }
			{ name: "heck" }
			{ name: "haha" }
			{ name: "hoote" }
		]
		let a = fzi.sort("he", l) do |x| x.name
		let b = [
			{ name: "heck" }
			{ name: "hello" }
			{ name: "hoote" }
		]
		expect a, isEqual, b

	test.run!

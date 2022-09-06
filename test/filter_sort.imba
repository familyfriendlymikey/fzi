import { isEqual, eq, gt, lt } from 'lodash'

let test = require('baretest')('filter sort')

export default do |expect, fzi|

	test("filter sort empty string array") do
		let l = []
		let a = fzi.filter_sort "test", l
		let b = []
		expect a, isEqual, b

	test("filter sort string array with single element") do
		let l = ["hello"]
		let a = fzi.filter_sort "h", l
		let b = ["hello"]
		expect a, isEqual, b

	test("filter sort string array with single element") do
		let l = ["hello"]
		let a = fzi.filter_sort "test", l
		let b = []
		expect a, isEqual, b

	test("filter sort empty object array") do
		let l = []
		let a = fzi.filter_sort "test", l, do |x| x.name
		let b = []
		expect a, isEqual, b

	test("filter sort object array with single element") do
		let l = [{ name: "hello" }]
		let a = fzi.filter_sort "h", l, do |x| x.name
		let b = [{ name: "hello" }]
		expect a, isEqual, b

	test("filter sort object array with single element") do
		let l = [{ name: "hello" }]
		let a = fzi.filter_sort "test", l, do |x| x.name
		let b = []
		expect a, isEqual, b

	test("filter sort strings") do
		let l = ["hello", "world", "heck", "haha", "hoote"]
		let a = fzi.filter_sort "he", l
		let b = ["heck", "hello", "hoote"]
		expect a, isEqual, b

	test("filter sort strings capital") do
		let a = ["a", "aa", "aA", "AA"]
		let b = fzi.filter_sort "a", a
		expect a, isEqual, b

	test("filter sort objects") do
		let l = [
			{ name: "hello" }
			{ name: "world" }
			{ name: "heck" }
			{ name: "haha" }
			{ name: "hoote" }
		]
		let a = fzi.filter_sort("he", l) do |x| x.name
		let b = [
			{ name: "heck" }
			{ name: "hello" }
			{ name: "hoote" }
		]
		expect a, isEqual, b

	test.run!

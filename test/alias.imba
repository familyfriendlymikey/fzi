import { isEqual, eq, gt, lt } from 'lodash'

let test = require('baretest')('alias')

export default do |expect, fzi|

	test("search non matching name") do
		let l = [
			{ name: "t", alias: "o" }
			{ name: "t", alias: "k" }
		]
		let a = fzi.search "o", l, (do $1.name), (do $1.alias)
		let b = [
			{ name: "t", alias: "o" }
		]
		expect a, isEqual, b

	test("search non matching alias") do
		let l = [
			{ name: "o", alias: "t" }
			{ name: "k", alias: "t" }
		]
		let a = fzi.search "o", l, (do $1.name), (do $1.alias)
		let b = [
			{ name: "o", alias: "t" }
		]
		expect a, isEqual, b

	test("search undefined alias") do
		let l = [
			{ name: "test" }
		]
		let a = fzi.search "test", l, (do $1.name), (do $1.alias)
		let b = [
			{ name: "test" }
		]
		expect a, isEqual, b

	test("search competing alias") do
		let l = [
			{ name: "dashboard", alias: "d" }
			{ name: "dash" }
		]
		let a = fzi.search "d", l, (do $1.name), (do $1.alias)
		let b = [
			{ name: "dashboard", alias: "d" }
			{ name: "dash" }
		]
		expect a, isEqual, b

	test("search competing alias long query") do
		let l = [
			{ name: "dashboard", alias: "d" }
			{ name: "dash" }
		]
		let a = fzi.search "dash", l, (do $1.name), (do $1.alias)
		let b = [
			{ name: "dash" }
			{ name: "dashboard", alias: "d" }
		]
		expect a, isEqual, b

	test("search competing alias even longer query") do
		let l = [
			{ name: "dashboard", alias: "d" }
			{ name: "dash" }
		]
		let a = fzi.search "dashb", l, (do $1.name), (do $1.alias)
		let b = [
			{ name: "dashboard", alias: "d" }
		]
		expect a, isEqual, b

	test.run!

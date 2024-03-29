import { isEqual, eq, gt, lt } from 'lodash'

let test = require('baretest')('score')

export default do |expect, fzi|

	test("should_prefer_starts_of_words") do
		let a = fzi.score("amor", "app/models/order")
		let b = fzi.score("amor", "app/models/zrder")
		expect a, gt, b

	test("should_prefer_consecutive_letters") do
		let a = fzi.score("amo", "app/m/foo")
		let b = fzi.score("amo", "app/models/foo")
		expect a, lt, b

	test("should_prefer_contiguous_over_letter_following_period") do
		let a = fzi.score("gemfil", "Gemfile.lock")
		let b = fzi.score("gemfil", "Gemfile")
		expect a, lt, b

	test("should_prefer_shorter_matches") do
		let a = fzi.score("abce", "abcdef")
		let b = fzi.score("abce", "abc de")
		expect a, gt, b

	test("should_prefer_shorter_matches") do
		let a = fzi.score("abc", "    a b c ")
		let b = fzi.score("abc", " a  b  c ")
		expect a, gt, b

	test("should_prefer_shorter_matches") do
		let a = fzi.score("abc", " a b c    ")
		let b = fzi.score("abc", " a  b  c ")
		expect a, gt, b

	test("should_prefer_shorter_candidates") do
		let a = fzi.score("test", "tests")
		let b = fzi.score("test", "testing")
		expect a, gt, b

	test("should_prefer_start_of_candidate") do
		let a = fzi.score("test", "testing")
		let b = fzi.score("test", "/testing")
		expect a, gt, b

	test("score_exact_score") do
		let a = fzi.score("abc", "abc")
		let b = fzi.SCORE_MAX
		expect a, eq, b

	test("score_exact_score") do
		let a = fzi.score("aBc", "abC")
		let b = fzi.SCORE_MAX
		expect a, eq, b

	test("score_empty_query") do
		let a = fzi.score("", "")
		let b = fzi.SCORE_MIN
		expect a, eq, b

	test("score_empty_query") do
		let a = fzi.score("", "a")
		let b = fzi.SCORE_MIN
		expect a, eq, b

	test("score_empty_query") do
		let a = fzi.score("", "bb")
		let b = fzi.SCORE_MIN
		expect a, eq, b

	test("score_gaps") do
		let a = fzi.score("a", "*a")
		let b = fzi.SCORE_GAP_LEADING
		expect a, eq, b

	test("score_gaps") do
		let a = fzi.score("a", "*ba")
		let b = fzi.SCORE_GAP_LEADING*2
		expect a, eq, b

	test("score_gaps") do
		let a = fzi.score("a", "**a*")
		let b = fzi.SCORE_GAP_LEADING*2 + fzi.SCORE_GAP_TRAILING
		expect a, eq, b

	test("score_gaps") do
		let a = fzi.score("a", "**a**")
		let b = fzi.SCORE_GAP_LEADING*2 + fzi.SCORE_GAP_TRAILING*2
		expect a, eq, b

	test("score_gaps") do
		let a = fzi.score("aa", "**aa**")
		let b = fzi.SCORE_GAP_LEADING*2 + fzi.SCORE_MATCH_CONSECUTIVE + fzi.SCORE_GAP_TRAILING*2
		expect a, eq, b

	test("score_gaps") do
		let a = fzi.score("aa", "**a*a**")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_GAP_LEADING + fzi.SCORE_GAP_INNER + fzi.SCORE_GAP_TRAILING + fzi.SCORE_GAP_TRAILING
		expect a, eq, b

	test("score_consecutive") do
		let a = fzi.score("aa", "*aa")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_MATCH_CONSECUTIVE
		expect a, eq, b

	test("score_consecutive") do
		let a = fzi.score("aaa", "*aaa")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_MATCH_CONSECUTIVE*2
		expect a, eq, b

	test("score_consecutive") do
		let a = fzi.score("aaa", "*a*aa")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_GAP_INNER + fzi.SCORE_MATCH_CONSECUTIVE
		expect a, eq, b

	test("score_slash") do
		let a = fzi.score("a", "/a")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_MATCH_SLASH
		expect a, eq, b

	test("score_slash") do
		let a = fzi.score("a", "*/a")
		let b = fzi.SCORE_GAP_LEADING*2 + fzi.SCORE_MATCH_SLASH
		expect a, eq, b

	test("score_slash") do
		let a = fzi.score("aa", "a/aa")
		let b = fzi.SCORE_GAP_LEADING*2 + fzi.SCORE_MATCH_SLASH + fzi.SCORE_MATCH_CONSECUTIVE
		expect a, eq, b

	test("score_capital") do
		let a = fzi.score("a", "bA")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_MATCH_CAPITAL
		expect a, eq, b

	test("score_capital") do
		let a = fzi.score("a", "baA")
		let b = fzi.SCORE_GAP_LEADING*2 + fzi.SCORE_MATCH_CAPITAL
		expect a, eq, b

	test("score_capital") do
		let a = fzi.score("aa", "baAa")
		let b = fzi.SCORE_GAP_LEADING*2 + fzi.SCORE_MATCH_CAPITAL + fzi.SCORE_MATCH_CONSECUTIVE
		expect a, eq, b

	test("score_dot") do
		let a = fzi.score("a", ".a")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_MATCH_DOT
		expect a, eq, b

	test("score_dot") do
		let a = fzi.score("a", "*a.a")
		let b = fzi.SCORE_GAP_LEADING*3 + fzi.SCORE_MATCH_DOT
		expect a, eq, b

	test("score_dot") do
		let a = fzi.score("a", "*a.a")
		let b = fzi.SCORE_GAP_LEADING + fzi.SCORE_GAP_INNER + fzi.SCORE_MATCH_DOT
		expect a, eq, b

	test.run!

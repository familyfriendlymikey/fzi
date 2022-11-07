const p = console.log

module.exports = new class fzi

	SCORE_MIN = -Infinity
	SCORE_MAX = Infinity
	SCORE_GAP_LEADING = -0.005
	SCORE_GAP_TRAILING = -0.005
	SCORE_GAP_INNER = -0.01
	SCORE_MATCH_CONSECUTIVE = 1.0
	SCORE_MATCH_SLASH = 0.9
	SCORE_MATCH_WORD = 0.8
	SCORE_MATCH_CAPITAL = 0.7
	SCORE_MATCH_DOT = 0.6

	M = new Array 100_000
	D = new Array 100_000
	B = new Array 100_000

	def search needle, haystacks, iteratee
		let lower_needle = needle.toLowerCase!
		let lower_haystack
		let haystack
		return [] unless haystacks.length > 0
		let scored = []
		if iteratee
			for obj in haystacks
				let haystack = iteratee obj
				continue unless typeof haystack is 'string'
				lower_haystack = haystack.toLowerCase!
				continue unless has_match lower_needle, lower_haystack
				let score = score needle, haystack, lower_needle, lower_haystack
				scored.push { haystack, score, obj }
			scored.sort(cmp).map do $1.obj
		else
			for haystack in haystacks
				continue unless typeof haystack is 'string'
				lower_haystack = haystack.toLowerCase!
				continue unless has_match lower_needle, lower_haystack
				let score = score needle, haystack, lower_needle, lower_haystack
				scored.push { haystack, score }
			scored.sort(cmp).map do $1.haystack

	def cmp a, b
		a.score < b.score and 1 or a.score > b.score and -1 or 0

	def score needle, haystack, lower_needle=needle.toLowerCase!, lower_haystack=haystack.toLowerCase!
		let n = needle.length
		let m = haystack.length
		if n < 1 or m < 1
			return this.SCORE_MIN
		if n is m
			return this.SCORE_MAX
		if m > 1024
			return this.SCORE_MIN
		this.compute needle, haystack, lower_needle, lower_haystack
		this.M[(n - 1)*m + (m - 1)]

	def idx rowLength, i, j
		i * rowLength + j

	def positions needle, haystack

		let n = needle.length
		let m = haystack.length
		let positions = new Array n

		if n < 1 or m < 1
			return positions

		if n is m
			for i in [0 ... n]
				positions[i] = i
			return positions

		if m > 1024
			return positions

		this.compute needle, haystack

		let match_required = false

		let i = n - 1
		let j = m - 1
		while i >= 0
			while j >= 0
				let ij = this.idx m, i, j
				let pij = this.idx m, i - 1, j - 1
				if this.D[ij] isnt this.SCORE_MIN and (match_required or this.D[ij] is this.M[ij])
					match_required = i and j and this.M[ij] is this.D[pij] + this.SCORE_MATCH_CONSECUTIVE
					positions[i] = j--
					break
				j--
			i--

		positions

	def replaceMatchedRanges needle, haystack, replace

		let n = needle.length
		let m = haystack.length
		let chars = new Array!

		if n < 1 or m < 1
			return haystack

		if n is m
			return replace haystack

		if m > 1024
			return haystack

		this.compute needle, haystack

		let match_required = false

		let last_match
		let i = n - 1
		let j = m - 1
		while i >= 0
			while j >= 0
				let ij = this.idx m, i, j
				let pij = this.idx m, i - 1, j - 1
				if this.D[ij] isnt this.SCORE_MIN and (match_required or this.D[ij] is this.M[ij])
					match_required = i and j and this.M[ij] is this.D[pij] + this.SCORE_MATCH_CONSECUTIVE
					last_match ??= j
					j--
					break
				else
					if last_match
						chars.push replace(haystack.substring(j + 1,last_match + 1))
						last_match = null
					chars.push haystack[j]
				j--
			i--

		if last_match isnt null and j >= 0
			chars.push replace haystack.substring(j + 1, last_match + 1)
		elif last_match isnt null
			chars.push replace haystack.substring(0,last_match + 1)

		while j >= 0
			chars.push haystack[j]
			j--

		chars.reverse!.join ''

	def replaceMatches needle, haystack, replace

		let n = needle.length
		let m = haystack.length
		let chars = new Array m

		if n < 1 or m < 1
			return haystack

		if n is m
			for i in [0 ... n]
				chars[i] = replace haystack[i]
			return chars.join ''

		if m > 1024
			return haystack

		this.compute needle, haystack

		let match_required = false

		let i = n - 1
		let j = m - 1
		while i >= 0
			while j >= 0
				let ij = this.idx m, i, j
				let pij = this.idx m, i - 1, j - 1
				if this.D[ij] isnt this.SCORE_MIN and (match_required or this.D[ij] is this.M[ij])
					match_required = i and j and this.M[ij] is this.D[pij] + this.SCORE_MATCH_CONSECUTIVE
					chars[j] = replace haystack[j]
					j--
					break
				else
					chars[j] = haystack[j]
				j--
			i--

		while j >= 0
			chars[j] = haystack[j]
			j--

		chars.join ''

	def has_match needle, haystack
		let i = 0
		let n = -1
		let letter
		while letter = needle[i++]
			if (n = haystack.indexOf(letter, n + 1)) is -1
				return no
		return yes

	def compute needle, haystack, lower_needle=needle.toLowerCase!, lower_haystack=haystack.toLowerCase!
		let n = needle.length
		let m = haystack.length
		precompute_bonus haystack
		for i in [0 ... n]
			let prev_score = this.SCORE_MIN
			let gap_score = i is n - 1 ? this.SCORE_GAP_TRAILING : this.SCORE_GAP_INNER
			for j in [0 ... m]
				let ij = this.idx m, i, j
				let pij = this.idx m, i - 1, j - 1
				if lower_needle[i] is lower_haystack[j]
					let score = this.SCORE_MIN
					if i is 0
						score = (j * this.SCORE_GAP_LEADING) + this.B[j]
					elif j > 0
						score = Math.max(this.M[pij] + this.B[j], this.D[pij] + this.SCORE_MATCH_CONSECUTIVE)
					this.D[ij] = score
					this.M[ij] = prev_score = Math.max(score, prev_score + gap_score)
				else
					this.D[ij] = this.SCORE_MIN
					this.M[ij] = prev_score = prev_score + gap_score

	def precompute_bonus haystack
		let m = haystack.length
		let last_ch = '/'
		for i in [0 ... m]
			let ch = haystack[i]
			if last_ch is '/'
				this.B[i] = this.SCORE_MATCH_SLASH
			elif last_ch is '-' or last_ch is '_' or last_ch is ' '
				this.B[i] = this.SCORE_MATCH_WORD
			elif last_ch is '.'
				this.B[i] = this.SCORE_MATCH_DOT
			elif islower(last_ch) and isupper(ch)
				this.B[i] = this.SCORE_MATCH_CAPITAL
			else
				this.B[i] = 0
			last_ch = ch

	def islower s
		return s.toLowerCase! is s

	def isupper s
		return s.toUpperCase! is s

export def replaceMatchesDiff needle, haystack, replaceMatch, replaceDiff

	return unless (replaceMatch or replaceDiff)

	let n = needle.length
	let m = haystack.length
	let chars = new Array m

	if n < 1 or m < 1
		return haystack

	if n is m
		for i in [0 ... n]
			chars[i] = replaceMatch haystack[i]
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
				chars[j] = replaceMatch ? replaceMatch(haystack[j]) : haystack[j]
				j--
				break
			else
				chars[j] = replaceDiff ? replaceDiff(haystack[j]) : haystack[j]
			j--
		i--

	while j >= 0
		chars[j] = replaceDiff ? replaceDiff(haystack[j]) : haystack[j]
		j--

	chars.join ''

# fzi

A super fast and accurate fuzzy filtering/sorting algorithm,
converted to Imba from jhawthorn's excellent JS version of [fzy](https://github.com/jhawthorn/fzy.js/).

## Installation
```
npm i fzi
```

## Usage
```
import fzi from 'fzi'

let notes = [
	{ content: "first note", id: 1 }
	{ content: "second note", id: 2 }
]

let query = "f"

let sorted_notes = fzi notes, query, "content"

console.log sorted_notes
```

## Differences From fzy.js
There are some notable differences from `fzy.js`:
- `fzy.js` only computes the score for a given needle and haystack.
But you're never just scoring one thing, you pretty much always want a sorted list in return.
So `fzi` only has one default export, `fzi`, which takes as its arguments a list, a query, and a keyname,
and returns a sorted list.
- Instead of sorting the list after everything is scored, I use a binary insertion sort.
- `fzy.js` allocates
[two new arrays](https://github.com/jhawthorn/fzy.js/blob/master/index.js#L63)
for each character in the search query.
`fzi` allocates the arrays once, before you compute the scores for the entire list, for increased performance.
- Removed positions highlighting. Open to putting it back in, but I use other highlighting methods in my apps.

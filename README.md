# fzi

A super fast and accurate fuzzy filtering/sorting algorithm forked from
[fzy.js](https://github.com/jhawthorn/fzy.js/) with added optimizations.

## Installation
```
npm i fzi
```

## Usage
`fzi.sort` takes a query, array, and an optional iteratee.

If an iteratee is not supplied, `fzi.search` will assume that it has been passed an array of strings.

Without iteratee:
```
import fzi from 'fzi'

let query = "f"

let array = [
	"first note"
	"second note"
]

let sorted_notes = fzi.search query, array
```
With iteratee:
```
import fzi from 'fzi'

let query = "f"

let array = [
	{ content: "first note", id: 1 }
	{ content: "second note", id: 2 }
]

let iteratee = do $1.content

let sorted_notes = fzi.search query, array, iteratee
```

`fzi.search` will silently skip any non-string elements.

## Differences From fzy.js
There are some notable differences from `fzy.js`:
- `fzi` is much faster because of two optimizations:
	- `fzy.js` instantiates a new array every time `score` is called, which is quite slow. `fzi` instantiates these arrays once per *import*.
	- `fzy.js` uses 2D arrays to store the scores, while `fzi` uses 1D arrays which are much faster.
- `fzi` is more convenient since it comes with a search method which accepts an array and an arbitrary iteratee.
- `fzi` does not have positions highlighting. I'm open to putting it back, but I didn't find it so useful in my apps.
- `fzi` is written in an awesome language called Imba.

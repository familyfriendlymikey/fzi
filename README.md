# fzi

A super fast and accurate fuzzy searching algorithm forked from
[fzy.js](https://github.com/jhawthorn/fzy.js/) with added optimizations.

## Installation
```
npm i fzi
```

## Usage

`fzi.search` takes a query, array, and an optional iteratee.

If an iteratee is not supplied, `fzi.search` will assume that it has been passed an array of strings.

Without iteratee:

```
import fzi from 'fzi'

let query = "f"

let array = [
	"first note"
	"second note"
]

let search_result = fzi.search query, array

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

let search_result = fzi.search query, array, iteratee
```

`fzi.search` will silently skip any non-string elements, both with and without an iteratee.

To get positions for an individual string, call `fzi.positions`:

```
let needle = "hlo"
let haystack = "hello"
let positions = fzi.positions needle, haystack
``

I've chosen to make the `positions` function separate because
there aren't really any elegant ways to include the positions
with the result without interfering with the simplicity of the
API. Performance wise, it's not much of a drawback at all. If you
want positions, you're likely displaying a list of something. The
list should only render the amount of elements that will fit in
the viewport, which means if you have a list of a million
elements, you'd only want the additional performance burden to be
on the elements that are actually in the view.

## Differences From fzy.js
There are some notable differences from `fzy.js`:
- `fzi` is much faster because of two optimizations:
	- `fzy.js` instantiates a new array every time `score` is called, which is quite slow. `fzi` instantiates these arrays once per *import*.
	- `fzy.js` uses 2D arrays to store the scores, while `fzi` uses 1D arrays which are much faster.
- `fzi` is more convenient since it comes with a search method which accepts an array and an arbitrary iteratee.
- `fzi` is written in an awesome language called Imba.

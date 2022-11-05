# fzi

`fzi` is (probably) the fastest and most accurate JavaScript
fuzzy searching algorithm. It is extremely effective for shorter
strings like file paths. It is not very effective at searching
long strings like paragraphs of prose.

## Performance

`fzi` was forked from the excellent
[fzy.js](https://github.com/jhawthorn/fzy.js/), however `fzi` is
much faster because it uses a 1D matrix representation and it
only instantiates the score matrix once per import. `fzi` also has
a `replaceMatches` function which is a much more performant way
of replacing matches than using an array of matching positions.

`fzi`'s api is also very convenient, coming with a `search`
function that accepts an arbitrary iteratee and a
`replaceMatches` function that accepts an arbitrary replace
function. With other search algorithms, you either have to score
every item yourself or create a class instance.

## Installation

```
npm i fzi
```

## Usage

All the following examples are written in a fantastic language
called `imba`, which compiles to readable JavaScript.

### search

```
fzi.search(needle, haystack, iteratee)
```

`fzi.search` takes a query, array, and an optional iteratee.

If an iteratee is not supplied, `fzi.search` will assume that it
has been passed an array of strings.

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

`fzi.search` will silently skip any non-string elements, both
with and without an iteratee.

### replaceMatches

```
fzi.replaceMatches(needle, haystack, replaceMatch, replaceDiff)
```

This is a very performant and convenient way of replacing fuzzy
matches in a string.

For example, to make all matches red in your terminal window:

```
# npm i colors
import 'colors'
let needle = "hlo"
let haystack = "hello"
fzi.replaceMatches(needle, haystack) do $1.red
```

Or to wrap each match with a `<span>`:

```
fzi.replaceMatches(needle, haystack) do "<span>{$1}</span>"
```

### `fzi.replaceMatchedRanges`

This will pass adjacent matches as one string to the callback
function, resulting in a cleaner output.

### `fzi.positions`

Returns an array of matching positions.
Probably not useful.

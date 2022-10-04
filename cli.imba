import fzi from './main.imba'
import fs from 'fs'
import readline from 'readline'

const p = console.log

const clear = "\x1b[0m"
const green = "\x1b[32m"
const pink = "\x1b[35m"
const red = "\x1b[31m"
const cyan = "\x1b[36m"
const blue = "\x1b[34m"

const place_cursor = do(x,y) "\x1b[{y};{x}H"
const clear_screen = "\x1b[2J"
const hide_cursor = "\x1b[?25l"
const show_cursor = "\x1b[?25h"
const smcup = "\x1b[?1049h"
const rmcup = "\x1b[?1049l"

# let input = fs.readFileSync "/dev/stdin","utf8"
let input = [
	"hehehe"
	"this is a test"
	"of this app"
	"since piping stdin"
	"is a huge pain in the ass"
	"for some reason"
]

class App

	def constructor
		process.stdin.setRawMode(yes)
		process.stdin.resume!
		process.stdout.write smcup
		draw!
		const options =
			input: process.stdin
			escapeCodeTimeout: 0
		const rl = readline.createInterface options
		readline.emitKeypressEvents process.stdin,rl

	@observable query = ""
	@observable selection_index = 0

	@autorun def draw
		let result = search_result
		if result.length
			result[selection_index] = "{blue}{result[selection_index]}{clear}"
		let output = hide_cursor +
			clear_screen +
			place_cursor(1,1) +
			query + "\n" +
			result.join('\n') +
			place_cursor(query.length+1,1) +
			show_cursor
		process.stdout.write output

	get search_result
		fzi.search(query,input)

	def main
		process.stdin.on('keypress') do
			switch $2.name
				when 'escape'
					process.stdout.write "{clear_screen}{show_cursor}{rmcup}"
					process.exit!
				when 'return'
					process.stdout.write "{clear_screen}{show_cursor}{rmcup}{search_result[selection_index]}\n"
					process.exit!
				when 'down'
					selection_index = Math.min(selection_index + 1, search_result.length - 1)
				when 'up'
					selection_index = Math.max(selection_index - 1, 0)
				when 'backspace'
					query = query.slice 0,-1
					selection_index = 0
				else
					query += $1
					selection_index = 0

new App!.main!

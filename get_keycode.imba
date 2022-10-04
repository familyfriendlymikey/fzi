const readline = require('readline')

process.stdin.setRawMode yes
let options =
	input: process.stdin
	escapeCodeTimeout: 0
let rl = readline.createInterface options
readline.emitKeypressEvents process.stdin,rl
process.stdin.on('keypress') do
	console.log $1, $2
	process.exit! if $2.name is 'q'

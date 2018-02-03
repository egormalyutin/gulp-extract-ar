{ assert } = require 'chai'

Vinyl      = require 'vinyl'
fs         = require 'fs'
ar         = require './'

describe 'ar', ->
	it 'extracts ar archive', (done) ->
		buff = fs.readFileSync 'fixtures/hello.a'
		realFile = fs.readFileSync 'fixtures/hello.txt'

		file = new Vinyl
			name: 'hello.a'
			contents: buff

		pipe = ar()

		pipe.write file

		pipe.once 'data', (data) ->
			if (Buffer.compare realFile, data.contents) is 0
				done()
			else
				done new Error 'Extracted files are different!'


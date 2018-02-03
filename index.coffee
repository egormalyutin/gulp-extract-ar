ar = require 'ar'

through     = require 'through2'
PluginError = require 'plugin-error'
Vinyl       = require 'vinyl'

NAME = 'gulp-extract-ar'

extract = ->
	through.obj (file, enc, cb) ->
		if file.isNull()
			return cb(null, file)

		if file.isBuffer()
			try
				archive = new ar.Archive file.contents
				files = archive.getFiles()
				for file in files
					@push new Vinyl
						cwd: './'
						path: file.name()
						contents: file.fileData()

			catch e
				new PluginError NAME, e
			return cb()

		if file.isStream()
			new PluginError NAME, 'Streaming isn\'t supported!'

		cb null, file
		return

module.exports = extract
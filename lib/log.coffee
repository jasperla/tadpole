fs			= require 'fs'
mkdirp	= require 'mkdirp'
date		= require './date'
config	= require '../config'

module.exports.log_uri = (uri, owner, msg) ->
	console.log "[#{date.format_date()}]: URI found: #{uri} (full msg: #{msg})"
	if config.html.enabled
		html_log(uri, msg, owner)

module.exports.log = (msg) ->
	console.log "[#{date.format_date()}]: msg"

# Quick'n'dirty HTML logging...
html_log = (uri, msg, owner) ->
	entry = "<p>#{date.format_date()}: <a href=\"#{uri}\" title=\"#{msg}\">#{uri}</a>(#{owner}).</br>"
	mkdirp(config.html.path)
	fd = fs.createWriteStream(config.html.path + 'index.html', {flags: 'a'})
	fd.write(entry)
	fd.close

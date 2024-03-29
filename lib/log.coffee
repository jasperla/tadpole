fs	= require 'fs'
mkdirp	= require 'mkdirp'
date	= require './date'
config	= require '../config'
util	= require 'util'

module.exports.log_uri = (uri, msg, owner) ->
	util.log "URI found: #{uri} (full msg: #{msg})"
	if config.html.enabled
		html_log(uri, msg, owner)

module.exports.log = (msg) ->
        util.log msg

# Quick'n'dirty HTML logging...
html_log = (uri, msg, owner) ->
	entry = "<p>#{date.format_date()}: <a href=\"#{uri}\" title=\"#{msg}\">#{uri}</a> (#{owner}).</br>"
	mkdirp(config.html.path)
	fd = fs.createWriteStream(config.html.path + 'index.html', {flags: 'a'})
	fd.write(entry)
	fd.close

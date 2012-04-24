date = require './date'

module.exports.log_uri = (uri, msg) ->
	console.log "[#{date.format_date()}]: URI found: #{uri} (full msg: #{msg})"

module.exports.log = (msg) ->
	console.log "[#{date.format_date()}]: msg"

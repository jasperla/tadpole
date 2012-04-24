date = require './date'

module.exports.log_uri = (msg) ->
	console.log "[#{date.format_date()}]: URI found: #{msg}"

module.exports.log = (msg) ->
	console.log "[#{date.format_date()}]: msg"

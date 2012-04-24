# Format the current date for something that's worth logging.
module.exports.format_date = () ->
	date = new Date()
	"#{date.getDate()}-#{date.getMonth() + 1}-#{date.getFullYear()} #{date.getHours()}:#{date.getMinutes()}:#{format_seconds(date.getSeconds())}"

format_seconds = (seconds) ->
	if seconds < 10
		'0' + seconds
	else
		seconds

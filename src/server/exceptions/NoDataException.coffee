class NoDataException extends Error
	constructor: (@message) ->
		@name = "NoDataException"
		Error.captureStackTrace(this, NoDataException)

module.exports = NoDataException

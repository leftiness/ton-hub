class BadDataException extends Error
	constructor: (@message) ->
		@name = "BadDataException"
		Error.captureStackTrace(this, BadDataException)

module.exports = BadDataException

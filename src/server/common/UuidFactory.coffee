factory =
	create: (len) ->
		array = []
		chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
		for [0 .. len - 1]
			i = @random 0, chars.length - 1
			array.push chars[i]
		array.join ""
	random: (min, max) ->
		Math.floor(Math.random() * (max - min + 1)) + min

module.exports = factory

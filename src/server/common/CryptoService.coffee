crypto = require "crypto-js"

config = require "../config.json"

service =
	pbkdf2: (password, salt) ->
		opts =
			hasher: crypto.algo.SHA256
			iterations: config.pbkdf2_iterations
		obj = crypto.PBKDF2 password, salt, opts
		return obj.toString()
	hmac: (accessToken, secret) ->
		obj = crypto.HmacSHA256 accessToken, secret
		return obj.toString()

module.exports = service

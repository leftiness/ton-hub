crypto = require "crypto-js"

service =
	pbkdf2: (password, salt) ->
		obj = crypto.PBKDF2 password, salt, { hasher: crypto.algo.SHA256 }
		return obj.toString()
	hmac: (accessToken, secret) ->
		obj = crypto.HmacSHA256 accessToken, secret
		return obj.toString()

module.exports = service

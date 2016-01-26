crypto = require "crypto-js"

config = require "../config.json"

b64 = (s) ->
	s = crypto.enc.Utf8.parse s
	s = crypto.enc.Base64.stringify s
	return s

service =
	pbkdf2: (message, salt) ->
		opts =
			hasher: crypto.algo.SHA256
			iterations: config.pbkdf2_iterations
		obj = crypto.PBKDF2 message, salt, opts
		return obj.toString()
	hmac: (message, secret) ->
		obj = crypto.HmacSHA256 message, secret
		return obj.toString()
	aes: (message, salt, secret) ->
		message = crypto.enc.Utf8.parse message
		salt = b64 salt
		secret = b64 secret
		obj = crypto.AES.encrypt message, secret, iv: salt
		return obj.toString()
	unaes: (cipher, salt, secret) ->
		salt = b64 salt
		secret = b64 secret
		obj = crypto.AES.decrypt cipher, secret, iv: salt
		return obj.toString(crypto.enc.Utf8)

module.exports = service

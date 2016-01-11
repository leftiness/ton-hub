uuid = require "node-uuid"

crypto = require "../common/CryptoService.js"
config = require "../config.json"

clients = []
secret = config.secret.oauth2_client_key

# TODO Obviously stubbed.

service =
	find: (id, done) ->
		for client in clients
			if client.id == id
				cipher = client.clientSecret
				decrypt = crypto.unaes cipher, client.salt, secret
				client.clientSecret = decrypt
				return done null, client
		return done null, null
	findByClientID: (clientID, done) ->
		for client in clients
			if client.clientID == clientID then return done null, client
		return done null, null
	save: (clientID, name, clientSecret, redirectURI, done) ->
		salt = uuid.v4();
		json =
			id: clients.length + 1
			clientID: clientID
			name: name
			clientSecret: crypto.aes clientSecret, salt, secret
			redirectURI: redirectURI
			salt: salt
		### TODO
		Add records with "approved: false". I should approve clients before they
		can actually access the API.
		###
		# TODO Check if record exists. If it does, return done(error)
		clients.push json
		return done null

stub = (err) -> if err then console.log "error creating these clients"
pmUrl = "https://www.getpostman.com/oauth2/callback"
taUrl = "http://localhost:5001/api/callback"
service.save "postman", "Postman", "secret", pmUrl, stub
service.save "ton-account", "ton-account", "secret", taUrl, stub

module.exports = service

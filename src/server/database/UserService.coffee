uuid = require "node-uuid"

crypto = require "../common/CryptoService.js"

users = []

# TODO Obviously stubbed.

service =
	find: (id, done) ->
		for user in users
			if user.id == id then return done null, user
		return done null, null
	findByUsername: (username, done) ->
		for user in users
			if user.username == username then return done null, user
		return done null, null
	save: (username, email, password, done) ->
		salt = uuid.v4();
		json =
			id: users.length + 1
			username: username
			password: crypto.pbkdf2 password, salt
			name: username
			email: email
			salt: salt
		# TODO Check if username exists. If it does, return done(error)
		users.push json
		return done null

stub = (err) -> if err then console.log "failed to create these users"
service.save "bob", "bobsmith@email.site", "secret", stub
service.save "joe", "joe_the_man@bestemail.com", "password", stub

module.exports = service

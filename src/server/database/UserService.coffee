users = [
	_ =
		id: "1"
		username: "bob"
		password: "secret"
		name: "Bob Smith"
		email: "bobsmith@email.site"
	_ =
		id: "2"
		username: "joe"
		password: "password"
		name: "Joe Davis"
		email: "joe_the_man@bestemail.com"
]

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

module.exports = service

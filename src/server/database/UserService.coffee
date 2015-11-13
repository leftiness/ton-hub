users = [
	_ =
		id: "1"
		username: "bob"
		password: "secret"
		name: "Bob Smith"
	_ =
		id: "2"
		username: "joe"
		password: "password"
		name: "Joe Davis"
]

# TODO Obviously stubbed.

service =
	find: (id, done) ->
		users.forEach (user) ->
			if user.id == id then return done null, user
		done null, null
	findByUsername: (username, done) ->
		users.forEach (user) ->
			if user.username == username then return done null, user
		done null, null

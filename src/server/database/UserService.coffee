users = [
	_ =
		id: "1"
		username: "bob"
		password: "4b4335301c98404d5a6f5f99814e47a2" # "secret"
		name: "Bob Smith"
		email: "bobsmith@email.site"
		salt: "c5473218-bad9-4e7f-a80f-9b78589a4c76"
	_ =
		id: "2"
		username: "joe"
		password: "d7b814ab354bf0b8d703b45c254834a7" # "password"
		name: "Joe Davis"
		email: "joe_the_man@bestemail.com"
		salt: "0186cb61-faab-4fd9-afce-d7f20464f0fc"
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

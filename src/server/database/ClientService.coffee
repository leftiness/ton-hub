clients = [
	_ =
		id: "1"
		name: "Samplr"
		clientID: "abc123"
		clientSecret: "ssh-secret"
]

# TODO Obviously stubbed.

service =
	find: (id, done) ->
		clients.forEach (client) ->
			if client.id == id then return done null, client
		done null, null
	findByClientID: (clientID, done) ->
		clients.forEach (client) ->
			if client.clientID == clientID then return done null, client
		done null, null

module.exports = service

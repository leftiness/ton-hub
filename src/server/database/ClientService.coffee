clients = [
	_ =
		id: "1"
		name: "Samplr"
		clientID: "abc123"
		clientSecret: "ssh-secret"
		redirectURI: "http://localhost:5000/cb"
]

# TODO Obviously stubbed.

service =
	find: (id, done) ->
		for client in clients
			if client.id == id then return done null, client
		return done null, null
	findByClientID: (clientID, done) ->
		for client in clients
			if client.clientID == clientID then return done null, client
		return done null, null

module.exports = service

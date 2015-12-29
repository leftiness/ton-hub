clients = [
	_ =
		id: "1"
		name: "ton-hub"
		clientID: "ton-hub"
		clientSecret: "secret"
		redirectURI: "http://localhost:5000/api/callback"
	_ =
		id: "2"
		name: "Postman"
		clientID: "postman"
		clientSecret: "secret"
		redirectURI: "https://www.getpostman.com/oauth2/callback"
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

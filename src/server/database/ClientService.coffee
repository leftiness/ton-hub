clients = [
	_ =
		id: "2"
		name: "Postman"
		clientID: "postman"
		clientSecret: "secret"
		redirectURI: "https://www.getpostman.com/oauth2/callback"
	_ =
		id: "3"
		name: "ton-account"
		clientID: "ton-account"
		clientSecret: "secret"
		redirectURI: "http://localhost:5001/api/callback"
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

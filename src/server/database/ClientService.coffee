clients = [
	_ =
		id: "2"
		name: "Postman"
		clientID: "postman"
		clientSecret: "e122da4e1f084ee28cb364bec5ad8e78" # "secret"
		redirectURI: "https://www.getpostman.com/oauth2/callback"
		salt: "b6ad41e9-ef5b-4d2d-af6b-a1bd559fb3c9"
	_ =
		id: "3"
		name: "ton-account"
		clientID: "ton-account"
		clientSecret: "222c6d034aa1de1bb6ba3b999952764f" # "secret"
		redirectURI: "http://localhost:5001/api/callback"
		salt: "b1f6102c-cf20-438d-a292-635f425487f6"
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

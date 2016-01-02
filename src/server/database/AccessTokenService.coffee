tokens = {}

# TODO Obviously stubbed.

service =
	find: (key, done) ->
		token = tokens[key]
		return done null, token
	save: (token, userID, clientID, authCode, done) ->
		obj =
			userID: userID
			clientID: clientID
			authCode: authCode
		tokens[token] = obj
		return done null
	delete: (token, done) ->
		delete tokens[token]
		return done null
	deleteByAuthCode: (authCode, done) ->
		for token in tokens
			if token.authCode is authCode then delete tokens[token]
		return done null

module.exports = service

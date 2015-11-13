tokens = {}

# TODO Obviously stubbed.

service =
	find: (key, done) ->
		token = tokens[key]
		done null, token
	save: (token, userID, clientID, done) ->
		obj =
			userID: userID
			clientID: clientID
		tokens[token] = obj
		done null

module.exports = service

codes = {}

# TODO Obviously stubbed.

service =
	find: (key, done) ->
		code = codes[key]
		done null, code
	save: (code, clientID, redirectURI, userID, done) ->
		obj =
			clientID: clientID
			redirectURI: redirectURI
			userID: userID
		codes[code] = obj
		done null
	delete: (key, done) ->
		delete codes[key]
		done null

module.exports = service

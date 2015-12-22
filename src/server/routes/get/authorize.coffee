ensure = require "connect-ensure-login"

auth = require "../../common/AuthService.js"
db = require "../../database/index.js"

### TODO
If I'm already logged in when GET /api/authorize, JSON is returned to the
browser... not to Angular. Therefore, before doing ensureLoggedIn(),
do ensureLoggedOut(). After that, they'll get directed to the login state,
where there will be logic to handle this JSON. This is an okay strategy.
If they're going to reauthorize, I might as well revalidate the login.
###

routes =
	verb: "get"
	path: "/authorize"
	fn: [
		ensure.ensureLoggedIn "/login"
		auth.authorization (clientID, redirectURI, done) ->
			db.clients.findByClientID clientID, (err, client) ->
				if err then return done err
				if !client then return done null, false
				if client.redirectURI != redirectURI then return done null, false
				done null, client, redirectURI
		(req, res) ->
			id = req.oauth2.transactionID
			client = req.oauth2.client
			redirect = req.oauth2.redirectURI
			# TODO Add oauth2 authorization scope parameter
			json =
				data:
					state: "authorize"
					params:
						id: id
						client: client.name
						redirect: redirect
			res.status(200).json json
		auth.errorHandler { mode: "indirect" }
	]

module.exports = routes

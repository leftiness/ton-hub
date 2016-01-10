ensure = require "connect-ensure-login"
oauth2 = require "oauth2orize"
uuid = require "node-uuid"

auth = require "../../common/AuthService.js"
db = require "../../database/index.js"

routes =
	verb: "get"
	path: "/oauth2/authorize"
	fn: [
		ensure.ensureLoggedIn "/login"
		auth.authorization (clientID, redirectURI, done) ->
			db.clients.findByClientID clientID, (err, client) ->
				if err then return done err
				if !client then return done null, false
				if client.redirectURI != redirectURI then return done null, false
				done null, client, redirectURI
		(req, res, next) ->
			id = req.oauth2.transactionID
			client = req.oauth2.client
			url = "/oauth2/confirm?id=#{id}&client=#{client.name}"
			state = req.query.state
			if !state
				message = "Missing required parameter: state"
				type = "invalid_request"
				return next new oauth2.AuthorizationError message, type
			# TODO Add oauth2 authorization scope parameter
			res.cookie "xsrf", uuid.v4()
			res.redirect url
		auth.errorHandler { mode: "indirect" }
	]

module.exports = routes

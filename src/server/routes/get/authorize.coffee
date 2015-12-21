ensure = require "connect-ensure-login"

auth = require "../../common/AuthService.js"
db = require "../../database/index.js"

routes =
	verb: "get"
	path: "/authorize"
	auth: false
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
			# TODO Add oauth2 authorization scope parameter
			redirect = "/authorize?id=#{id}&client=#{client.name}"
			res.redirect redirect
		auth.errorHandler { mode: "indirect" }
	]

module.exports = routes

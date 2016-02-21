ensure = require "connect-ensure-login"
oauth2 = require "oauth2orize"
uuid = require "node-uuid"

auth = require "../../common/AuthService.js"
Clients = require "../../database/Clients.js"
NoDataException = require "../../exceptions/NoDataException.js"
BadDataException = require "../../exceptions/BadDataException.js"

routes =
	verb: "get"
	path: "/oauth2/authorize"
	fn: [
		ensure.ensureLoggedIn "/sign_in"
		auth.authorization (client, redirectUri, done) ->
			Clients.findOne where: client: client
				.then (model) ->
					if !model then throw new NoDataException()
					if !model.active then throw new BadDataException()
					if model.redirectUri != redirectUri then throw new BadDataException()
					return done null, model.toJSON(), redirectUri
				.catch NoDataException, BadDataException, (err) ->
					return done null, false
				.catch (err) -> return done err
		(req, res, next) ->
			id = req.oauth2.transactionID
			client = req.oauth2.client.client
			url = "/oauth2/confirm?id=#{id}&client=#{client}"
			state = req.query.state
			if !state
				message = "Missing required parameter: state"
				type = "invalid_request"
				return next new oauth2.AuthorizationError message, type
			# TODO Add oauth2 authorization scope parameter
			res.redirect url
		auth.errorHandler mode: "indirect"
	]

module.exports = routes

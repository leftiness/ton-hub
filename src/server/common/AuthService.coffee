oauth2 = require "oauth2orize"
passport = require "passport"
ensure = require "connect-ensure-login"
uuid = require "node-uuid"
moment = require "moment"

Clients = require "../database/Clients.js"
AuthCodes = require "../database/AuthCodes.js"
AccessTokens = require "../database/AccessTokens.js"
NoDataException = require "../exceptions/NoDataException.js"
BadDataException = require "../exceptions/BadDataException.js"

server = oauth2.createServer()

# TODO Use new sequelize db access code. Get rid of old stubbed stuff.

server.serializeClient (client, done) ->
	done null, client.id

server.deserializeClient (id, done) ->
	Clients.findOne where: id: id
		.then (model) -> return done null, model.toJSON()
		.catch (err) -> return done err

server.grant oauth2.grant.code (client, redirectUri, user, ares, done) ->
	tooOld = createdAt: $lt: moment().subtract(5, "days").valueOf()
	fromThisUser =
		userId: user.id
		clientId: client.id
	AuthCodes.destroy where: $or: [ tooOld, fromThisUser ]
		.then () ->
			return AuthCodes.create
				userId: user.id
				clientId: client.id
				redirectUri: redirectUri
		.then (model) -> return done null, model.authCode
		.catch (err) -> return done err

server.exchange oauth2.exchange.code (client, code, redirectUri, done) ->
	userId = undefined
	AuthCodes.findOne where: authCode: code
		.then (model) ->
			if !model then throw new NoDataException()
			if client.id isnt model.clientId then throw new BadDataException()
			if redirectUri isnt model.redirectUri then throw new BadDataException()
			userId = model.userId
			return AuthCodes.destroy where: authCode: code
		.then () -> return AccessTokens.create
			userId: userId
			clientId: client.id
			authCode: code
		.then (model) -> return done null, model.accessToken
		.catch NoDataException, (err) ->
			AccessTokens.destroy where: authCode: code
				.then () ->	return done null, false
		.catch BadDataException, (err) -> return done null, false
		.catch (err) -> return done err

module.exports = server

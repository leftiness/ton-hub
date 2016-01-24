passport = require "passport"
LocalStrategy = require("passport-local").Strategy
ClientPasswordStrategy = require("passport-oauth2-client-password").Strategy
BearerStrategy = require("passport-http-bearer").Strategy

messages = require "./messages.js"
crypto = require "./CryptoService.js"
config = require "../config.json"
Clients = require "../database/Clients.js"
AccessTokens = require "../database/AccessTokens.js"
Users = require "../database/Users.js"
NoDataException = require "../exceptions/NoDataException.js"
BadDataException = require "../exceptions/BadDataException.js"

genericError = { message: messages.error.generic }
invalidCredentials = { message: messages.invalid.credentials }
invalidToken = { message: messages.invalid.token }
invalidProof = { message: messages.invalid.proof }
passReqToCallback = { passReqToCallback: true }
key = config.secret.oauth2_client_key

passport.serializeUser (user, done) ->
	return done null, user.id

passport.deserializeUser (id, done) ->
	Users.findOne where: id: id
		.then (model) -> return done null, model.toJSON()
		.catch (err) -> return done err

passport.use new LocalStrategy (username, password, done) ->
	Users.findOne where: username: username
		.then (model) ->
			if !model then throw new NoDataException invalidCredentials
			if model.password isnt (crypto.pbkdf2 password, model.salt)
				throw new BadDataException invalidCredentials
			return done null, model.toJSON()
		.catch NoDataException, BadDataException, (err) ->
			return done null, false, err.message
		.catch (err) -> return done err, false, genericError

passport.use new ClientPasswordStrategy (client, clientSecret, done) ->
	Clients.findOne where: client: client
		.then (model) ->
			if !model then throw new NoDataException invalidCredentials
			if model.clientSecret isnt clientSecret
				throw new BadDataException invalidCredentials
			return done null, model.toJSON()
		.catch NoDataException, BadDataException (err) ->
			return done null, false, err.message
		.catch (err) -> return done err, false, genericError

passport.use new BearerStrategy passReqToCallback, (req, accessToken, done) ->
	user = undefined
	clientId = undefined
	AccessTokens.findOne where: accessToken: accessToken
		.then (model) ->
			if !model then throw new NoDataException invalidToken
			clientId = model.clientId
			return Users.findOne where: id: model.userId
		.then (model) ->
			### TODO
			To keep this example simple, restricted scopes are not implemented
			and this is just for illustrative purposes.
			###
			if !model then throw new NoDataException invalidToken
			user = model.toJSON()
			return Clients.findOne where: id: clientId
		.then (model) ->
			if !model then throw new NoDataException invalidToken
			proof = req.headers["x-ton-secret-proof"]
			expected = crypto.hmac accessToken, model.clientSecret
			if !proof or proof isnt expected
				throw new BadDataException invalidProof
			return done null, user, scope: "*"
		.catch NoDataException, (err) ->
			return done null, false, err.message
		.catch BadDataException, (err) ->
			AccessTokens.destroy where: accessToken: accessToken
				.then () ->	return done null, false, err.message
		.catch (err) -> return done err, false, genericError

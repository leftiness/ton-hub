passport = require "passport"
LocalStrategy = require("passport-local").Strategy
ClientPasswordStrategy = require("passport-oauth2-client-password").Strategy
BearerStrategy = require("passport-http-bearer").Strategy

db = require "../database/index.js"
messages = require "./messages.js"
crypto = require "./CryptoService.js"
config = require "../config.json"

genericError = { message: messages.error.generic }
invalidCredentials = { message: messages.invalid.credentials }
invalidToken = { message: messages.invalid.token }
invalidProof = { message: messages.invalid.proof }
passReqToCallback = { passReqToCallback: true }
key = config.secret.oauth2_client_key

# TODO Use new sequelize db access code. Get rid of old stubbed stuff.

passport.serializeUser (user, done) ->
	return done null, user.id

passport.deserializeUser (id, done) ->
	db.users.find id, (err, user) ->
		return done err, user

passport.use new LocalStrategy (username, password, done) ->
	db.users.findByUsername username, (err, user) ->
		if err then return done err, false, genericError
		else if !user then return done null, false, invalidCredentials
		else if user.password isnt (crypto.pbkdf2 password, user.salt)
			return done null, false, invalidCredentials
		else return done null, user

passport.use new ClientPasswordStrategy (clientID, clientSecret, done) ->
	db.clients.findByClientID clientID, (err, client) ->
		if err then return done err, false, genericError
		else if !client then return done null, false, invalidCredentials
		else if client.clientSecret isnt clientSecret
			return done null, false, invalidCredentials
		else return done null, client

passport.use new BearerStrategy passReqToCallback, (req, accessToken, done) ->
	db.accessTokens.find accessToken, (err, token) ->
		if err then	return done err, false, genericError
		else if !token then return done null, false, invalidToken
		else db.users.find token.userID, (err, user) ->
			### TODO
			To keep this example simple, restricted scopes are not implemented
			and this is just for illustrative purposes.
			###
			if err then return done err, false, genericError
			else if !user then return done null, false, invalidToken
			else db.clients.find token.clientID, (err, client) ->
				if err then return done err, false, genericError
				else if !client then return done err, false, invalidToken
				else
					### TODO
					Set a "dev" environment var to disable this app secret proof check
					and therefore allow postman to make requests using just access token.
					###
					proof = req.headers["x-ton-secret-proof"]
					expected = crypto.hmac accessToken, client.clientSecret
					if !proof or proof isnt expected
						db.accessTokens.delete accessToken, (err) ->
							if err then return done err, false, genericError
							else return done err, false, invalidProof
					else return done null, user, { scope: "*" }

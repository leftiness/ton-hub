passport = require "passport"
LocalStrategy = require("passport-local").Strategy
ClientPasswordStrategy = require("passport-oauth2-client-password").Strategy
BearerStrategy = require("passport-http-bearer").Strategy

db = require "../database/index.js"
messages = require "./messages.js"

generic = messages.error.generic
credentials = messages.invalid.credentials

passport.serializeUser (user, done) ->
	return done null, user.id

passport.deserializeUser (id, done) ->
	db.users.find id, (err, user) ->
		return done err, user

passport.use new LocalStrategy (username, password, done) ->
	db.users.findByUsername username, (err, user) ->
		if err then return done err, false, { message: generic }
		else if !user then return done null, false, { message: credentials }
		else if user.password isnt password
			return done null, false, { message: credentials }
		else return done null, user

passport.use new ClientPasswordStrategy (clientID, clientSecret, done) ->
	db.clients.findByClientID clientID, (err, client) ->
		if err then return done err, false, { message: generic }
		else if !client then return done null, false, { message: credentials }
		else if client.clientSecret isnt clientSecret
			return done null, false, { message: credentials }
		else return done null, client

passport.use new BearerStrategy (accessToken, done) ->
	db.accessTokens.find accessToken, (err, token) ->
		if err then	return done err, false, { message: generic }
		else if !token then return done null, false, { message: credentials }
		else db.users.find token.userID, (err, user) ->
			### TODO
			To keep this example simple, restricted scopes are not implemented
			and this is just for illustrative purposes.
			###
			### TODO
			When !user, invalidate this access token. Remember that there were
			other security tips in the oauth2 specification.
			###
			### TODO
			When a token is sent that's invalid, the oauth2 specification says that
			there are certain messages that are supposed to be sent back. there are
			standard steps for this. Look them up. Is passport/oauth2orize doing that
			already, or do I have to that myself?
			###
			if err then return done err, false, { message: generic }
			else if !user then return done null, false, { message: credentials }
			else return done null, user, { scope: "*" }

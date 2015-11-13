passport = require "passport"
LocalStrategy = require("passport-local").Strategy
BasicStrategy = require("passport-http").BasicStrategy
ClientPasswordStrategy = require("passport-oauth2-client-password").Strategy
BearerStrategy = require("passport-http-bearer").Strategy

db = require ("../database/index.js")

passport.serializeUser (user, done) ->
	done null, user.id

passport.deserializeUser (id, done) ->
	db.users.find id, (err, user) ->
		done err, user

passport.use new LocalStrategy (username, password, done) ->
	db.users.findByUsername username, (err, user) ->
		if err then return done err
		if !user then return done null, false
		if user.password isnt password then return done null, false
		done null, user

passport.use new BasicStrategy (username, password, done) ->
	db.clients.findByClientID username, (err, client) ->
		if err then return done err
		if !client then return done null, false
		if client.clientSecret isnt password then return done null, false
		done null, client

passport.use new ClientPasswordStrategy (clientID, clientSecret, done) ->
	db.clients.findByClientID clientID, (err, client) ->
		if err then return done err
		if !client then return done null, false
		if client.clientSecret isnt clientSecret then return done null, false
		done null, client

passport.use new BearerStrategy (accessToken, done) ->
	db.accessTokens.find accessToken, (err, token) ->
		if err then return done err
		if !token then return done null, false
		db.users.find token.userID, (err, user) ->
			### TODO
			To keep this example simple, restricted scopes are not implemented
			and this is just for illustrative purposes.
			###
			info = { scope: "*" }
			done null, user, info

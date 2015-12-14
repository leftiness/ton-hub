oauth2 = require "oauth2orize"
passport = require "passport"
ensure = require "connect-ensure-login"

db = require "../database/index.js"
uuid = require "./UuidFactory.js"

server = oauth2.createServer()

server.serializeClient (client, done) ->
	done null, client.id

server.deserializeClient (id, done) ->
	db.clients.find id, (err, client) ->
		if err then return done err
		done null, client

server.grant oauth2.grant.code (client, redirectURI, user, ares, done) ->
	code = uuid.create 16
	db.authorizationCodes.save code, client.id, redirectURI, user.id, (err) ->
		if err then return done err
		done null, code

server.exchange oauth2.exchange.code (client, code, redirectURI, done) ->
	db.authorizationCodes.find code, (err, authCode) ->
		if err then return done err
		if authCode is undefined then return done null, false
		if client.id isnt authCode.clientID then return done null, false
		if redirectURI isnt authCode.redirectURI then return done null, false
		db.authorizationCodes.delete code, (err) ->
			if err then return done err
			token = uuid.create 256
			db.accessTokens.save token, authCode.userID, authCode.clientID, (err) ->
				if err then return done err
				done null, token

service = {}

service.authorization = [
		ensure.ensureLoggedIn "/login"
		server.authorization (clientID, redirectURI, done) ->
			db.clients.findByClientID clientID, (err, client) ->
				if err then return done err
				### TODO
				WARNING: For security purposes, it is highly advisable to check that
      	redirectURI provided by the client matches one registered with
      	the server. For simplicity, this example does not. You have
      	been warned.
				###
				done null, client, redirectURI
		(req, res) ->
			id = req.oauth2.transactionID
			user = req.user
			client = req.oauth2.client
			# TODO Need to create /authorize module on front end.
			# It'll tell an authenticated user "this app requests these permissions."
			# The user can then accept or deny.
			redirect = "/authorize?transactionID=#{id}&user=#{user}&client=#{client}"
			res.redirect redirect
	]

service.decision = [
		ensure.ensureLoggedIn "/login"
		server.decision()
	]

###TODO
I want to use bearer tokens instead of basic/oauth2-client-password.
Remember to remove the dependency on passport-http, passport-local,
and passport-oauth2-client-password if I don't use them.
###

service.token = [
	passport.authenticate "oauth2-client-pasword", { session: false }
	server.token()
	server.errorHandler()
]

module.exports = service

oauth2 = require "oauth2orize"
passport = require "passport"
ensure = require "connect-ensure-login"
uuid = require "node-uuid"

db = require "../database/index.js"

server = oauth2.createServer()

server.serializeClient (client, done) ->
	done null, client.id

server.deserializeClient (id, done) ->
	db.clients.find id, (err, client) ->
		if err then return done err
		done null, client

server.grant oauth2.grant.code (client, redirectURI, user, ares, done) ->
	code = uuid.v4()
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
			token = uuid.v4()
			db.accessTokens.save token, authCode.userID, authCode.clientID, (err) ->
				if err then return done err
				done null, token

service = {}

service.authorization = [
		ensure.ensureLoggedIn "/login"
		server.authorization (clientID, redirectURI, done) ->
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
		server.errorHandler { mode: "indirect" }
	]

service.decision = [
		ensure.ensureLoggedIn "/login"
		server.decision()
	]

service.token = [
	passport.authenticate "oauth2-client-pasword", { session: false }
	server.token()
	server.errorHandler()
]

module.exports = service

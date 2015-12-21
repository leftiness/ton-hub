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

module.exports = server

"use strict"

express = require "express"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
passport = require "passport"
session = require "express-session"
morgan = require "morgan"
prettyjson = require "prettyjson"

config = require "../config.json"
routes = require "./routes/index.js"
exceptionHandler = require "./common/ExceptionHandler.js"
database = require "./common/DatabaseService.js"

require "./common/passportConfig.js"

env = process.env.NODE_ENV || "development"
app = express()
port = process.env.PORT || config.port
# TODO Not keyboard cat... but what should it be? What are these options anyway?
sessionConf =
	secret: "keyboard cat"
	resave: false
	saveUninitialized: true

app.set "view engine", "jade"
app.set "views", "#{__dirname}/views"

app.use morgan "dev"
# TODO Warning The default server-side session storage, MemoryStore, is
# purposely not designed for a production environment. It will leak memory
# under most conditions, does not scale past a single process, and is meant
# for debugging and developing.
app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: false }
app.use cookieParser(config.secret.cookie_secret)
app.use session sessionConf
app.use express.static __dirname
app.use passport.initialize()
app.use passport.session()

database.init()
	.then ->
		return Promise.all routes.map (rt) ->
			return Promise.resolve app[rt.verb] rt.path, rt.fn
	.then ->
		return Promise.resolve app.use exceptionHandler
	.then ->
		return Promise.resolve app.listen port
	.then ->
		console.log "All systems are go! Port: #{port}"
	.catch (err) ->
		console.log "Failed to start"
		console.log prettyjson.render err, noColor: true

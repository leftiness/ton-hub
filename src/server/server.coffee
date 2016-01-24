"use strict"

express = require "express"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
passport = require "passport"
session = require "express-session"
morgan = require "morgan"

config = require "../config.json"
routes = require "./routes/index.js"
exceptionHandler = require "./common/ExceptionHandler.js"
tokenInterceptor = require "./common/TokenInterceptor.js"
database = require "./database/database.js"

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
app.use tokenInterceptor

routes.forEach (rt) ->
	app[rt.verb] rt.path, rt.fn

app.use exceptionHandler

database.sync().then ->
	if env is "development"
		for own k, v of database.models
			v._dummy?()
	app.listen port, ->
		console.log "All systems are go! Port: #{port}"

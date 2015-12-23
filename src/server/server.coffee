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

require "./common/passportConfig.js"

app = express()
port = process.env.PORT || config.port
opt =
	root: __dirname
# TODO Not keyboard cat... but what should it be? What are these options anyway?
sessionConf =
	secret: "keyboard cat"
	resave: false
	saveUninitialized: true

app.use morgan "dev"
# TODO Warning The default server-side session storage, MemoryStore, is
# purposely not designed for a production environment. It will leak memory
# under most conditions, does not scale past a single process, and is meant
# for debugging and developing.
app.use session sessionConf
app.use express.static __dirname
app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: false }
app.use cookieParser()
app.use passport.initialize()
app.use passport.session()

###TODO
Honestly not even sure if all of this stuff works. That's why I'm creating a
branch. When I finally get it all working, I'll have a good, clean auth feature,
and I'll just commit those changes in one commit to the master branch without
keeping this history full of bumbling. :)

Guess I'll probably commit when I have the auth working with stubbed db stuff.
The real db implementation will come later.
###

routes.forEach (rt) ->
	app[rt.verb] "/api#{rt.path}", rt.fn

app.all "*", (req, res) ->
	res.sendFile "index.html", opt

app.use exceptionHandler

app.listen (port), ->
	console.log "All systems are go! Port: #{port}"

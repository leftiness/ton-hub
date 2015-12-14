"use strict"

express = require "express"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
passport = require "passport"
session = require "express-session"
ensure = require "connect-ensure-login"
morgan = require "morgan"

auth = require "./common/AuthService.js"
config = require "../config.json"
routes = require "./routes/index.js"

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
app.use cookieParser()
app.use passport.initialize()
app.use passport.session()

###TODO
This guy uses an express.errorHandler

app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));

What does that do for you?

No idea what I'll have to do to get the session stuff working, either. ^.^"
###

###TODO
Honestly not even sure if all of this stuff works. That's why I'm creating a
branch. When I finally get it all working, I'll have a good, clean auth feature,
and I'll just commit those changes in one commit to the master branch without
keeping this history full of bumbling. :)

Guess I'll probably commit when I have the auth working with stubbed db stuff.
The real db implementation will come later.
###

###TODO
Still have to implement a protected resource like this.

https://github.com/jaredhanson/oauth2orize/blob/master/examples/express2/user.js

And this

app.get "/api/userinfo", user.info

Notice how the function (req, res) is an array. Apparently you can pass an array
of functions to express, and it will just go through them one at a time. I guess
if one of them fails, it won't continue going on to the next one. So, if the
passport req/res function fails, it won't go on to the req/res function for
returning the protected resource.
###

###TODO
Might still need to do something to make connect-ensure-login work.
https://github.com/jaredhanson/connect-ensure-login
###

app.use "/api", router

confRoute = (rt, type) ->
	app[rt.verb] "/api/#{type}#{rt.path}", [
		ensure.ensureLoggedIn "/login"
		passport.authenticate type
		rt.fn
	]

routes.forEach (rt) ->
	# TODO Harden the local API routes. Only allow ton-hub to do that.
	# The bearer API routes are for others to use.
	# Harden by using client password strategy instead of local strategy?
	if !rt.auth or rt.custom then app[rt.verb] "/api#{rt.path}", rt.fn
	if rt.local then confRoute rt, "local"
	if rt.bearer then confRoute rt, "bearer"
	
app.all "*", (req, res) ->
	res.sendFile "index.html", opt

app.listen (port), ->
	console.log "All systems are go! Port: #{port}"

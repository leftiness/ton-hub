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

routes.forEach (rt) ->
	# TODO Harden the local API routes. Only allow ton-hub to do that.
	# The bearer API routes are for others to use.
	# Harden by using client password strategy instead of local strategy?
	if !rt.auth then app[rt.verb] "/api#{rt.path}", rt.fn
	else app[rt.verb] "/api#{rt.path}", [
		ensure.ensureLoggedIn "/login"
		rt.fn
	]

app.all "*", (req, res) ->
	res.sendFile "index.html", opt

app.listen (port), ->
	console.log "All systems are go! Port: #{port}"

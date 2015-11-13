"use strict"

express = require "express"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
passport = require "passport"

auth = require "./common/AuthService.js"
config = require "../config.json"
routes = require "./routes/index.js"

require "./common/passportConfig.js"

app = express()
port = process.env.PORT || config.port
router = express.Router()
opt =
	root: __dirname

routes.forEach (route) ->
	router[route.verb] route.path, route.fn

app.use express.static __dirname
app.use bodyParser.json()
app.use cookieParser()
#TODO app.use express.session { secret : "keyboard cat" }
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

app.all "*", (req, res) ->
	res.sendFile "index.html", opt

app.listen (port), ->
	console.log "All systems are go! Port: #{port}"

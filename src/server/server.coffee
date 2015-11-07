"use strict"

express = require "express"
bodyParser = require "body-parser"

routes = require "./routes/index.js"

app = express()
port = process.env.PORT || 5000
router = express.Router()

routes.forEach (route) ->
	router[route.verb] route.path, route.fn

app.use express.static __dirname
app.use bodyParser.json()

app.use "/api", router

app.listen (port), ->
	console.log "All systems are go! Port: #{port}"

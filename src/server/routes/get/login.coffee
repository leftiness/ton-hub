uuid = require "node-uuid"

route =
	verb: "get"
	path: "/login"
	fn: [
		(req, res) ->
			xsrf = uuid.v4()
			json =
				error: req.query?.error
				xsrf: xsrf
			opts =
				signed: true
				httpOnly: true
				maxAge: 300000
				#secure: true #TODO Requires working HTTPS
			res.cookie "xsrf", xsrf, opts
			res.render "login", json
	]

module.exports = route

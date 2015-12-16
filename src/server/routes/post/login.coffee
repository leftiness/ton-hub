passport = require "passport"

route =
	verb: "post"
	path: "/login"
	auth: false
	fn: (req, res, next) ->
		### TODO
		Have to protect login route with client password strategy so that
		only ton-hub can use the login route. This will enforce the usage of
		bearer tokens on api routes. After that, the local strategy will
		authenticate the user credentials, and oauth2 redirection stuff can happen.
		###
		auth = passport.authenticate "local", (err, user, info) ->
			if err then return next err
			else if !user
				json =
					reason:
						info.message
				return res.status(401).json json
			else req.logIn user, (err) ->
				### TODO
				Instead of sending status 200, I think I'll need to send a 3xx status
				to redirect the browser to /api/authorize. Have to preserve the
				parameters (?foo=bar&fizz=buzz) from the external app during that
				redirection phase. If there weren't any parameters, then it's a login
				for ton-hub itself.
				###
				if err then return next err
				else return res.status(200).send()
		return auth req, res, next

module.exports = route

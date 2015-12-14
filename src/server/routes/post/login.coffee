passport = require "passport"

route =
	verb: "post"
	path: "/local/login"
	auth: true
	local: false
	bearer: false
	custom: true
	fn: (req, res, next) ->
		auth = passport.authenticate "local", (err, user, info) ->
			if err then return next err
			else if !user
				json =
					reason:
						info.message
				return res.status(401).json json
			else
				return res.status(200).json json
		return auth req, res, next

module.exports = route

passport = require "passport"
uuid = require "node-uuid"

xsrf = require "../../common/XsrfService.js"
config = require "../../../config.json"

route =
	verb: "post"
	path: "/login"
	fn: [
		xsrf.check
		(req, res, next) ->
			auth = passport.authenticate "local", (err, user, info) ->
				if err then return next err
				else if !user
					message = encodeURIComponent info.message
					url = "/login?error=#{message}"
					return res.redirect url
				else req.login user, (err) ->
					returnTo = req.session?.returnTo
					if returnTo then delete req.session.returnTo
					if err then return next err
					else if !returnTo
						json =
							error: "invalid_request"
							error_description: "Missing returnTo parameter"
						return next json
					else return res.redirect returnTo
			return auth req, res, next
	]

module.exports = route

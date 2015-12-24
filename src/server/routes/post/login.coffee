passport = require "passport"

secrets = require "../../common/secrets.js"

route =
	verb: "post"
	path: "/login"
	fn: (req, res, next) ->
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
				else if returnTo then return res.redirect returnTo
				else
					# TODO oauth2 scope stuff
					client = secrets.oauth2.client_id
					redirect = encodeURIComponent secrets.oauth2.redirect_uri
					url = "/api/authorize?response_type=code&client_id=#{client}"
					url += "&redirect_uri=#{redirect}&scope=foo"
					return res.redirect url
		return auth req, res, next

module.exports = route

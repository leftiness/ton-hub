passport = require "passport"
uuid = require "node-uuid"

config = require "../../../config.json"

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
					client = config.secret.oauth2.client_id
					redirect = encodeURIComponent config.secret.oauth2.redirect_uri
					state = uuid.v4()
					url = "/api/authorize?response_type=code&client_id=#{client}"
					url += "&redirect_uri=#{redirect}&scope=foo&state=#{state}"
					opts =
						signed: true
						maxAge: 300000
						httpOnly: true
						#secure: true # TODO Secure cookie requires working HTTPS...
					res.cookie "ton-state", state, opts
					return res.redirect url
		return auth req, res, next

module.exports = route

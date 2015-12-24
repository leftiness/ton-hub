passport = require "passport"

route =
	verb: "post"
	path: "/login"
	fn: (req, res, next) ->
		auth = passport.authenticate "local", (err, user, info) ->
			if err then return next err
			else if !user
				json =
					reason:
						info.message
				return res.status(401).json json
			else req.logIn user, (err) ->
				redir = req.session?.returnTo
				if redir then delete req.session.returnTo
				if err then return next err
				else if redir then return res.redirect redir
				else return res.status(200).json { data: state: "home" }
		return auth req, res, next

module.exports = route

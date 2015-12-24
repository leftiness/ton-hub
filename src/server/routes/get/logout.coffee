ensure = require "connect-ensure-login"

route =
	verb: "get"
	path: "/logout"
	fn: [
		(req, res) ->
			if req.isAuthenticated and req.isAuthenticated() then req.logout()
			res.redirect "/login"
	]

module.exports = route

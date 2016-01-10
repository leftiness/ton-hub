ensure = require "connect-ensure-login"

route =
	verb: "get"
	path: "/logout"
	fn: [
		(req, res) ->
			if req.isAuthenticated and req.isAuthenticated() then req.logout()
			res.status(200).send()
	]

module.exports = route

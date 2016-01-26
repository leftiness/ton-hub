passport = require "passport"

route =
	verb: "get"
	path: "/identity"
	fn: [
		passport.authenticate "bearer", session: false
		(req, res) ->
			res.json username: req.user.username
	]

module.exports = route

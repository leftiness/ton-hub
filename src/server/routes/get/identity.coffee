passport = require "passport"

route =
	verb: "get"
	path: "/api/identity"
	fn: [
		passport.authenticate "bearer", { session: false }
		(req, res) ->
			res.json { username: req.user.username }
	]

module.exports = route

passport = require "passport"

routes =
	verb: "post"
	path: "/api/settings"
	fn: [
		passport.authenticate "bearer", session: false
		(req, res) ->
			# TODO Stubbed
			res.status(200).send()
	]

module.exports = routes

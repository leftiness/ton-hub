passport = require "passport"

routes =
	verb: "post"
	path: "/api/settings"
	fn: [
		passport.authenticate "bearer", { session: false }
		(req, res) ->
			# TODO Stubbed
			b = req.body
			settings =
				name: b.name
				surname: b.surname
				email: b.email
			json =
				data: settings
			res.status(200).send()
	]

module.exports = routes

passport = require "passport"

routes =
	verb: "get"
	path: "/api/settings"
	fn: [
		passport.authenticate "bearer", session: false
		(req, res) ->
			# TODO Stubbed
			json =
				data:
					name: "Brandon"
					surname: "Parmenter"
					email: "leftiness@gmail.com"
			res.status(200).json json
	]

module.exports = routes

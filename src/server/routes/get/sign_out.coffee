route =
	verb: "get"
	path: "/sign_out"
	fn: [
		(req, res) ->
			if req.isAuthenticated and req.isAuthenticated() then req.logout()
			res.status(200).send()
	]

module.exports = route

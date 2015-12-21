route =
	verb: "post"
	path: "/signup"
	fn: (req, res) ->
		# TODO Stubbed
		b = req.body
		user =
			username: b.username
			password: b.password
			confirm: b.confirm
			email: b.email
		res.status(200).send()

module.exports = route

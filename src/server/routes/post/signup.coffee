route =
	verb: "post"
	path: "/signup"
	fn: (req, res) ->
		b = req.body
		user =
			username: b.username
			password: b.password
			confirm: b.confirm
			email: b.email
		# Obviously this is not the final function
		res.status(200).send()

module.exports = route

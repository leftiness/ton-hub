routes =
	verb: "get"
	path: "/callback"
	fn: (req, res) ->
		code = req.query?.code
		### TODO
		Stubbed. So close to done. All that's left is taking this auth code and
		providing it along with client id, client secret, and maybe some other
		params. Send that to POST /api/token, and I get an access token.
		###
		res.status(200).send()

module.exports = routes

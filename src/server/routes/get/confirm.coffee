xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/oauth2/confirm"
	fn: [
		xsrf.set
		(req, res) ->
			xsrf = req.getXsrf()
			id = req.query?.id
			client = req.query?.client
			name = req.user.name
			email = req.user.email
			json =
				xsrf: xsrf
				id: id
				client: client
				name: name
				email: email
			res.render "confirm", json
	]

module.exports = route

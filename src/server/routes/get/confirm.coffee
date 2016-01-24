xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/oauth2/confirm"
	fn: [
		xsrf.set
		(req, res) ->
			json =
				xsrf: req.getXsrf()
				id: req.query?.id
				client: req.query?.client
				name: req.user.displayName
				email: req.user.email
			res.render "confirm", json
	]

module.exports = route

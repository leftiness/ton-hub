xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/login"
	fn: [
		xsrf.set
		(req, res) ->
			json =
				error: req.query?.error
				xsrf: req.getXsrf()
			res.render "login", json
	]

module.exports = route

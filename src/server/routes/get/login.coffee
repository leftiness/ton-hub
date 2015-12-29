xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/login"
	fn: [
		xsrf.set
		(req, res) ->
			xsrf = req.getXsrf()
			json =
				error: req.query?.error
				xsrf: xsrf
			res.render "login", json
	]

module.exports = route

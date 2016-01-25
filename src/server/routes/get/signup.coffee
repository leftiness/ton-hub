xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/signup"
	fn: [
		xsrf.set
		(req, res) ->
			json =
				error: req.query?.error
				xsrf: req.getXsrf()
			res.render "signup", json
	]

module.exports = route

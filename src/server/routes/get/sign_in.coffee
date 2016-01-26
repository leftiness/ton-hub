xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/sign_in"
	fn: [
		xsrf.set
		(req, res) ->
			json =
				error: req.query?.error
				xsrf: req.getXsrf()
			res.render "sign_in", json
	]

module.exports = route

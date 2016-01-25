xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/activate"
	fn: [
		xsrf.set
		(req, res) ->
			json =
				error: req.query?.error
				email: req.query?.email
				xsrf: req.getXsrf()
			res.render "activate", json
	]

module.exports = route

xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/register_account"
	fn: [
		xsrf.set
		(req, res) ->
			json =
				error: req.query?.error
				xsrf: req.getXsrf()
			res.render "register_account", json
	]

module.exports = route

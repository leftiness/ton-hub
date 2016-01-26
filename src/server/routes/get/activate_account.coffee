xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/activate_account"
	fn: [
		xsrf.set
		(req, res) ->
			json =
				error: req.query?.error
				email: req.query?.email
				xsrf: req.getXsrf()
			res.render "activate_account", json
	]

module.exports = route

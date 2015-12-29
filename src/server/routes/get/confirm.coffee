xsrf = require "../../common/XsrfService.js"

route =
	verb: "get"
	path: "/confirm"
	fn: [
		xsrf.set
		(req, res) ->
			xsrf = req.getXsrf()
			id = req.query?.id
			client = req.query?.client
			res.render "confirm", { xsrf: xsrf, id: id, client: client }
	]

module.exports = route

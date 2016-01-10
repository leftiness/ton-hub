route =
	verb: "get"
	path: "/teapot"
	fn: (req, res) ->
		res.status(418).render "teapot"

module.exports = route

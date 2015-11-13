auth = require "../../common/AuthService.js"

routes =
	verb: "get"
	path: "/authorize"
	fn: auth.authorization

module.exports = routes

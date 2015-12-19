auth = require "../../common/AuthService.js"

routes =
	verb: "get"
	path: "/authorize"
	auth: false
	fn: auth.authorization

module.exports = routes

auth = require "../../common/AuthService.js"

routes =
	verb: "get"
	path: "/client/authorize"
	auth: true
	fn: auth.authorization

module.exports = routes

auth = require "../../common/AuthService.js"

routes =
	verb: "get"
	path: "/client/authorize"
	auth: false
	local: false
	bearer: false
	custom: true
	fn: auth.authorization

module.exports = routes

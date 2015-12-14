auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/client/token"
	auth: false
	local: false
	bearer: false
	custom: true
	fn: auth.token

module.exports = routes

auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/token"
	auth: false
	fn: auth.token

module.exports = routes

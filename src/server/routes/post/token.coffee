auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/token"
	fn: auth.token

module.exports = routes

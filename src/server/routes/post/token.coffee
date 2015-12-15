auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/client/token"
	auth: true
	fn: auth.token

module.exports = routes

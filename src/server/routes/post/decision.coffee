auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/decision"
	auth: false
	fn: auth.decision

module.exports = routes

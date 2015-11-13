auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/decision"
	fn: auth.decision

module.exports = routes

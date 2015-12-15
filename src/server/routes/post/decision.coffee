auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/client/decision"
	auth: true
	fn: auth.decision

module.exports = routes

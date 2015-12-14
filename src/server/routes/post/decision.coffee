auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/client/decision"
	auth: false
	local: false
	bearer: false
	custom: true
	fn: auth.decision

module.exports = routes

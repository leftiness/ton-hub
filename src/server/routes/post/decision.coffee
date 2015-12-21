ensure = require "connect-ensure-login"

auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/decision"
	auth: false
	fn: [
		ensure.ensureLoggedIn "/login"
		auth.decision()
	]

module.exports = routes

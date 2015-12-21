ensure = require "connect-ensure-login"

auth = require "../../common/AuthService.js"

routes =
	verb: "post"
	path: "/decision"
	fn: [
		ensure.ensureLoggedIn "/login"
		auth.decision()
	]

module.exports = routes

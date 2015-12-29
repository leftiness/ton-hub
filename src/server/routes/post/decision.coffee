ensure = require "connect-ensure-login"

auth = require "../../common/AuthService.js"
xsrf = require "../../common/XsrfService.js"

routes =
	verb: "post"
	path: "/decision"
	fn: [
		ensure.ensureLoggedIn "/api/login"
		xsrf.check
		auth.decision()
	]

module.exports = routes

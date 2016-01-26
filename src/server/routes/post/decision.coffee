ensure = require "connect-ensure-login"

auth = require "../../common/AuthService.js"
xsrf = require "../../common/XsrfService.js"

routes =
	verb: "post"
	path: "/oauth2/decision"
	fn: [
		ensure.ensureLoggedIn "/sign_in"
		xsrf.check
		auth.decision()
	]

module.exports = routes

auth = require "../../common/AuthService.js"
passport = require "passport"

routes =
	verb: "post"
	path: "/oauth2/token"
	fn: [
		passport.authenticate "oauth2-client-password", { session: false }
		auth.token()
		auth.errorHandler()
	]

module.exports = routes

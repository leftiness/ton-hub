auth = require "../../common/AuthService.js"
passport = require "passport"

routes =
	verb: "post"
	path: "/token"
	auth: false
	fn: [
		passport.authenticate "oauth2-client-pasword", { session: false }
		auth.token()
		auth.errorHandler()
	]

module.exports = routes

ensure = require "connect-ensure-login"

auth = require "../../common/AuthService.js"
messages = require "../../common/messages.js"

routes =
	verb: "post"
	path: "/decision"
	fn: [
		ensure.ensureLoggedIn "/api/login"
		(req, res, next) ->
			cookie = req.cookies.xsrf
			if cookie then res.clearCookie "xsrf"
			post = req.body.xsrf
			if !cookie or !post or (cookie isnt post)
				return next { error: messages.invalid.xsrf }
			else next()
		auth.decision()
	]

module.exports = routes

uuid = require "node-uuid"

messages = require "./messages.js"

mid =
	set: (req, res, next) ->
		xsrf = uuid.v4()
		opts =
			signed: true
			httpOnly: true
			#secure: true #TODO Needs https
		res.cookie "xsrf", xsrf, opts
		req.getXsrf = -> return xsrf
		return next()
	check: (req, res, next) ->
		cookie = req.signedCookies?.xsrf
		res.clearCookie "xsrf"
		post = req.body?.xsrf
		if !cookie or !post or (cookie isnt post)
			return next { error: messages.invalid.xsrf }
		else return next()

module.exports = mid

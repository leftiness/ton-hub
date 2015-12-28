request = require "request"

url = require("../../common/constants.js").hub_url
config = require "../../../config.json"
messages = require "../../common/messages.js"

routes =
	verb: "post"
	path: "/callback"
	fn: (req, res, next) ->
		err = req.body?.error
		desc = req.body?.error_description
		if err or desc
			json =
					reason: err
			return res.status(400).json json
		code = req.body.code
		state = req.body.state
		cookie = req.signedCookies["ton-state"]
		if cookie then res.clearCookie "ton-state"
		if !state or !cookie or (state isnt cookie)
			json =
				reason: messages.invalid.state
			return res.status(400).json json
		conf =
			method: "POST"
			uri: "#{url}/api/token"
			json:
				grant_type: "authorization_code"
				code: code
				client_id: config.secret.oauth2.client_id
				client_secret: config.secret.oauth2.client_secret
				redirect_uri: config.secret.oauth2.redirect_uri
		request conf, (err, response, body) ->
			status = response.statusCode
			if err then return next err
			else res.status(status).json body

module.exports = routes

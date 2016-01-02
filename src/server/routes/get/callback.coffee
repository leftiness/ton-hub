request = require "request"

url = require("../../common/constants.js").hub_url
config = require "../../../config.json"
messages = require "../../common/messages.js"

route =
	verb: "get"
	path: "/callback"
	fn: [
		(req, res, next) ->
			err = req.query?.error
			desc = req.query?.error_description
			if err or desc
				json =
					error: err
					error_description: desc
				return next json
			code = req.query?.code
			state = req.query?.state
			cookie = req.signedCookies["ton-state"]
			if cookie then res.clearCookie "ton-state"
			if !state or !cookie or (state isnt cookie)
				json =
					error: "invalid_request"
					error_description: messages.invalid.state
				return next json
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
				if err then return next err
				error = body?.error
				desc = body?.error_description
				type = body?.token_type
				token = body?.access_token
				if error or desc or !token or !type
					json = {}
					json.error = err || "invalid_request"
					json.error_description = desc if desc?
					return next json
				else
					opt =
						signed: true
						httpOnly: true
						#secure: true #TODO requires https
					res.cookie "access_token", token, opt
					res.cookie "token_type", type, opt
				res.render "callback"
	]

module.exports = route

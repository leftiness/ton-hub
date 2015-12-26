request = require "request"

url = require("../../common/constants.js").hub_url
config = require "../../../config.json"

### TODO
Stubbed. So close to done. All that's left is taking this auth code and
providing it along with client id, client secret, and maybe some other
params. Send that to POST /api/token, and I get an access token.
###

routes =
	verb: "get"
	path: "/callback/:code"
	fn: (req, res, next) ->
		code = req.params?.code
		conf =
			method: "POST"
			uri: "#{url}/api/token"
			json:
				grant_type: "authorization_code"
				code: code
				client_id: config.secret.oauth2.client_id
				client_secret: config.secret.oauth2.client_secret
				redirect_uri: config.secret.oauth2.redirect_uri
		# TODO Not sure how refresh tokens will work with this...
		request conf, (err, response, body) ->
			status = response.statusCode
			if err then return next err
			else res.status(status).json body

module.exports = routes

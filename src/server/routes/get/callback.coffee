request = require "request"

url = require("../../common/constants.js").hub_url
messages = require "../../common/messages.js"

### TODO
Stubbed. So close to done. All that's left is taking this auth code and
providing it along with client id, client secret, and maybe some other
params. Send that to POST /api/token, and I get an access token.
###

routes =
	verb: "get"
	path: "/callback"
	fn: (req, res) ->
		code = req.query?.code
		redirect = req.query?.redirect
		conf =
			method: "POST"
			uri: "#{url}/api/token"
			postData: _ =
				grant_type: "authorization_code"
				code: code
				redirect_uri: redirect
				client_id: "ton-hub"
				client_secret: "secret"
		# TODO Should get id and secret from a secrets file which isn't published.
		# TODO Not sure how refresh tokens will work with this...
		request conf, (err, response, body) ->
			if response.statusCode is 200
				console.log "rekt" # TODO Stubbed. Should send token. Etc.
				res.status(200).json {}
			else if response.statusCode is 401
				res.status(401).json { reason: response.body }
			else res.status(500).send() # TODO Stubbed. Should have reason.



module.exports = routes

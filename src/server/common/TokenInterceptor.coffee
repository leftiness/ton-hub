inter = (req, res, next) ->
	access_token = req.signedCookies?.access_token
	token_type = req.signedCookies?.token_type
	header = req.headers.authorization
	if access_token and token_type and !header
		req.headers.authorization = "#{token_type} #{access_token}"
	return next()

module.exports = inter

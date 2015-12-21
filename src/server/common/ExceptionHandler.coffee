util = require "util"
uuid = require "node-uuid"

handler = (err, req, res, next) ->
	id = uuid.v4()
	body = util.inspect req.body
	error = util.inspect err
	json =
		id: id
		method: req.method
		url: req.url
		body: req.body
		err: err
	console.log util.inspect json
	res.redirect "/error?id=#{id}"

module.exports = handler

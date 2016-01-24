uuid = require "node-uuid"
prettyjson = require "prettyjson"

handler = (err, req, res, next) ->
	id = uuid.v4()
	opts = { noColor: true }
	# TODO Shouldn't show the body if it has sensitive information...
	data =
		id: id
		method: req.method
		url: req.url
		body: req.body
		status: err.status
		name: err.name
		error: err.error || err.code
		message: err.error_description || err.message
	json =
		data: prettyjson.render data, opts
	log =
		data: data
		err: err
	console.log prettyjson.render log, opts
	res.render "error", json

module.exports = handler

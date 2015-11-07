url = require("../../common/constants.js").bacon
service = (require "../../common/RequestService.js") url

route =
	verb: "get"
	path: "/bacon"
	fn: (req, res) ->
		query =
			type: "all-filler"
			paras: 2
			format: "text"
		complete = (response) ->
			json =
				data: response.body
			res.status response.status
				.send json
		error = (error) ->
			json =
				reason: error.reason
			res.status error.status
				.send json
		service.request "get", "/", query
			.then complete, error

module.exports = route

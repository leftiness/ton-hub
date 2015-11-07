# url = require("../../common/constants.js").hub # TODO
# service = (require "../../common/RequestService.js") url # TODO

routes =
	verb: "get"
	path: "/settings"
	fn: (req, res) ->
		### TODO
		complete = (response) ->
		error = (error) ->
		service.request "get", "/settings"
			.then complete, error
		###
		json =
			data:
				name: "Brandon"
				surname: "Parmenter"
				email: "leftiness@gmail.com"
		res.status(200).json json

module.exports = routes

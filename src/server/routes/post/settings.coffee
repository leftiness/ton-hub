# url = require("../../common/constants.js").hub # TODO
# service = (require "../../common/RequestService.js") url # TODO

routes =
	verb: "post"
	path: "/settings"
	fn: (req, res) ->
		### TODO
		complete = (response) ->
		error = (error) ->
		service.request "post", "/settings"
			.then complete, error
		###
		b = req.body
		user =
			username: b.username
			token: b.token
		settings =
			name: b.name
			surname: b.surname
			email: b.email
		json =
			data: settings
		res.status(200).send()

module.exports = routes

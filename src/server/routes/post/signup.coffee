messages = require "../../common/messages.js"
Users = require "../../database/Users.js"

invalidEmail = { data: reason: messages.invalid.email }
invalidUsername = { data: reason: messages.invalid.username }
invalidName = { data: reason: messages.invalid.name }

route =
	verb: "post"
	path: "/signup"
	fn: (req, res, next) ->
		Users.create
				username: req.body.username
				email: req.body.email
				password: req.body.password
				displayName: req.body.displayName
			.then (model) -> res.status(200).send()
			.catch (err) -> return next err

module.exports = route

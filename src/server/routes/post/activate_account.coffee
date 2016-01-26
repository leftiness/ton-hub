seq = require "sequelize"

xsrf = require "../../common/XsrfService.js"
messages = require "../../common/messages.js"
Users = require "../../database/Users.js"
NoDataException = require "../../exceptions/NoDataException.js"
BadDataException = require "../../exceptions/BadDataException.js"

route =
	verb: "post"
	path: "/activate_account"
	fn: [
		xsrf.check
		(req, res, next) ->
			username = req.body.username
			Users.findOne where: username: username
				.then (model) ->
					if !model then throw new NoDataException()
					if model.activationCode isnt req.body.activationCode
						throw new BadDataException()
					update = active: true
					where = where: username: username
					return Users.update update, where
				.then () ->
					return res.redirect "/sign_in"
				.catch NoDataException, (err) ->
					message = messages.invalid.username
					return res.redirect "/activate_account?error=#{message}"
				.catch BadDataException, (err) ->
					message = messages.invalid.activation
					return res.redirect "/activate_account?error=#{message}"
				.catch (err) -> return next err
		]

module.exports = route

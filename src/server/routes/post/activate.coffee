seq = require "sequelize"

xsrf = require "../../common/XsrfService.js"
messages = require "../../common/messages.js"
Users = require "../../database/Users.js"
NoDataException = require "../../exceptions/NoDataException.js"
BadDataException = require "../../exceptions/BadDataException.js"

route =
	verb: "post"
	path: "/activate"
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
					return res.redirect "/login"
				.catch NoDataException, (err) ->
					return res.redirect "/activate?error=#{messages.invalid.username}"
				.catch BadDataException, (err) ->
					return res.redirect "/activate?error=#{messages.invalid.activation}"
				.catch (err) -> return next err
		]

module.exports = route

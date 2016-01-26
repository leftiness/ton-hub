seq = require "sequelize"
moment = require "moment"

xsrf = require "../../common/XsrfService.js"
messages = require "../../common/messages.js"
Users = require "../../database/Users.js"

route =
	verb: "post"
	path: "/register_account"
	fn: [
		xsrf.check
		(req, res, next) ->
			Users.destroy
					where:
						createdAt: $lt: moment().subtract(5, "days").valueOf()
						active: false
				.then () ->
					return Users.create
							username: req.body.username
							email: req.body.email
							password: req.body.password
							displayName: req.body.displayName
				.then (model) ->
					# TODO Send email with activation code and username.
					# TODO Remove console.log of activation code
					console.log "Activation: #{model.activationCode}"
					url = "/activate_account?email=#{req.body.email}"
					return res.redirect url
				.catch seq.ValidationError, (err) ->
					paths = []
					err.errors.forEach (error) ->
						paths.push error.path
					message = "#{messages.invalid.field}: #{paths}"
					url = "/register_account?error=#{message}"
					return res.redirect url
				.catch (err) -> return next err
		]

module.exports = route

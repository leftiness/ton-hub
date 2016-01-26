seq = require "sequelize"

Users = require "../../database/Users.js"
BadDataException = require "../../exceptions/BadDataException.js"

val = seq.Validator

route =
	verb: "post"
	path: "/identity"
	fn: [
		(req, res, next) ->
			username = req.body.username
			Users.build username: username
				.validate skip: [ "email", "password", "displayName" ]
				.then (err) ->
					if err then throw new BadDataException()
					else return Users.findOne where: username: username
				.then (model) ->
					status = if !model then 200 else 400
					return res.status(status).send()
				.catch BadDataException, (err) -> return res.status(400).send()
				.catch (err) -> return next err
	]

module.exports = route

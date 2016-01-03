db = require "../../database/index.js"
messages = require "../../common/messages.js"

invalidConfirm = { data: reason: messages.invalid.password_confirm }
invalidEmail = { data: reason: messages.invalid.email }
invalidUsername = { data: reason: messages.invalid.username }
invalidName = { data: reason: messages.invalid.name }

route =
	verb: "post"
	path: "/signup"
	fn: (req, res, next) ->
		username: req.body.username
		password: req.body.password
		confirm: req.body.confirm
		email: req.body.email
		name = req.body.name
		if !username then res.status(400).json invalidUsername
		else if password isnt confirm then res.status(400).json invalidConfirm
		else if !email
			# TODO Email regex check
			res.status(400).json invalidEmail
		else if !name
			# TODO Name length check... Other checks on this field and others?
			res.status(400).json invalidName
		else db.users.save username, email, name, password, (err) ->
			if err then return next err
			else res.status(200).send()

module.exports = route

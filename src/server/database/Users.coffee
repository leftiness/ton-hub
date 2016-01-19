Seq = require "sequelize"
uuid = require "node-uuid"

db = require "./database.js"
crypto = require "../common/CryptoService.js"
config = require "../config.json"

Users = db.define "AuthCodes", fields, options

fields =
	id:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		primaryKey: true
	username:
		type: Seq.STRING
		allowNull: false
		unique: true
		validate:
			isAlphanumeric: true
			notEmpty: true
	password:
		type: Seq.STRING
		allowNull: false
		validate:
			isAlphanumeric: true
			notEmpty: true
	displayName:
		type: Seq.STRING
		allowNull: false
		validate:
			isAlphanumeric: true
			notEmpty: true
	salt:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		unique: true

options =
	classMethods:
		comparePasswords: (fromUser, fromDatabase, salt) ->
			hashed = crypto.pbkdf2 fromUser, salt
			return hashed is fromDatabase
	hooks:
		beforeCreate: (user, options) ->
			unhashed = user.password
			salt = uuid.v4()
			hashed = crypto.pbkdf2 unhashed, salt
			user.password = hashed
			user.salt = salt
		beforeUpdate: (user, options) ->
			unhashed = user.password
			if !!unhashed
				salt = uuid.v4()
				hashed = crypto.pbkdf2 unhashed, salt, secret
				user.password = hashed
				user.salt = salt

### TODO
Each model class will have a function for creating dummy data. If the env var
is dev, then server.js will do database.models.forEach (model) -> model.dummy()
to fill the tables with some dummy data. If is dev, then sqlite in memory, so no
worries about junk data.
###

module.exports = Users

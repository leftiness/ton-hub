Seq = require "sequelize"
uuid = require "node-uuid"

db = require "./database.js"
crypto = require "../common/CryptoService.js"
config = require "../config.json"

Users = db.define "Users", {
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
			len: [ 1, 65 ]
	email:
		type: Seq.STRING
		allowNull: false
		validate:
			isEmail: true
			notEmpty: true
			len: [ 1, 255 ]
	password:
		type: Seq.STRING
		allowNull: false
		validate:
			isAlphanumeric: true
			notEmpty: true
	displayName:
		type: Seq.STRING
		allowNull: false
		unique: true
		validate:
			is: [ "^[a-zA-Z0-9`_]*$", "i" ]
			notEmpty: true
			len: [ 1, 13 ]
	salt:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		unique: true
	active:
		type: Seq.BOOLEAN
		defaultValue: false
	activationCode:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
} , {
	classMethods:
		_comparePasswords: (fromUser, fromDatabase, salt) ->
			hashed = crypto.pbkdf2 fromUser, salt
			return hashed is fromDatabase
		_dummy: ->
			Users.create
				username: "ada"
				email: "ada@gmail.com"
				password: "ada"
				displayName: "Ada"
				active: true
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
}

module.exports = Users

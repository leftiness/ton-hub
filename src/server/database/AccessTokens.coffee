Seq = require "sequelize"

db = require "./database.js"
Users = require "./Users.js"
Clients = require "./Clients.js"
AuthCodes = require "./AuthCodes.js"

AccessTokens = db.define "AccessTokens", fields

fields =
	id:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		primaryKey: true
	accessToken:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		unique: true
	userId:
		type: Seq.STRING
		allowNull: false
		unique: "userId:clientId"
		validate:
			isAlphanumeric: true
			notEmpty: true
		references:
			model: Users
			key: "id"
	clientId:
		type: Seq.STRING
		allowNull: false
		unqiue: "userId:clientId"
		validate:
			isAlphanumeric: true
			notEmpty: true
		references:
			model: Clients
			key: "id"
	authCode:
		type: Seq.UUID
		allowNull: false
		unique: true
		validate:
			isUUID: 4
			notEmpty: true
		references:
			model: AuthCodes
			key: "id"

module.exports = AccessTokens

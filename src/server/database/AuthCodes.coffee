Seq = require "sequelize"

db = require "./database.js"
Users = require "./Users.js"
Clients = require "./Clients.js"

AuthCodes = db.define "AuthCodes", {
	id:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		primaryKey: true
	authCode:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		unique: true
	userId:
		type: Seq.UUID
		allowNull: false
		unique: "userId:clientId"
		validate:
			isAlphanumeric: true
			notEmpty: true
		references:
			model: Users
			key: "id"
	clientId:
		type: Seq.UUID
		allowNull: false
		unqiue: "userId:clientId"
		validate:
			isAlphanumeric: true
			notEmpty: true
		references:
			model: Clients
			key: "id"
	redirectUri:
		type: Seq.STRING
		allowNull: false
		validate:
			isUrl: true
			notEmpty: true
		references:
			model: Clients
			key: "redirectUri"
}

module.exports = AuthCodes

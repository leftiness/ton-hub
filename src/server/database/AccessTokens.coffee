Seq = require "sequelize"

db = require "./database.js"
Users = require "./Users.js"
Clients = require "./Clients.js"

AccessTokens = db.define "AccessTokens", {
	id:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		primaryKey: true
	accessToken:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		unique: true
	userId:
		type: Seq.UUID
		allowNull: false
		validate:
			isUUID: 4
			notEmpty: true
		references:
			model: Users
			key: "id"
	clientId:
		type: Seq.UUID
		allowNull: false
		validate:
			isUUID: 4
			notEmpty: true
		references:
			model: Clients
			key: "id"
	authCode:
		type: Seq.UUID
		allowNull: false
		validate:
			isUUID: 4
			notEmpty: true
}

module.exports = AccessTokens

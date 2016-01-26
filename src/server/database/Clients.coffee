Seq = require "sequelize"
uuid = require "node-uuid"

db = require "./database.js"
crypto = require "../common/CryptoService.js"
config = require "../config.json"

secret = config.secret.oauth2_client_key

Clients = db.define "Clients", {
	id:
		type: Seq.UUID
		defaultValue: Seq.UUIDV4
		primaryKey: true
	client:
		type: Seq.STRING
		allowNull: false
		unique: true
		validate:
			isAlphanumeric: true
			notEmpty: true
	clientSecret:
		type: Seq.STRING
		allowNull: false
		validate:
			notEmpty: true
	salt:
		type: Seq.UUID
		unique: true
	redirectUri:
		type: Seq.STRING
		allowNull: false
		unique: true
		validate:
			isUrl: true
			notEmpty: true,
	active:
		type: Seq.STRING
		defaultValue: false
} , {
	classMethods:
		_compareSecrets: (fromUser, fromDatabase, salt) ->
			encrypted = crypto.aes fromUser, salt, secret
			return encrypted is fromDatabase
		_dummy: ->
			Clients.create
					client: "postman"
					clientSecret: "secret"
					redirectUri: "https://www.getpostman.com/oauth2/callback"
					approved: true
				.then () ->
					Clients.create
						client: "tonaccount"
						clientSecret: "secret"
						redirectUri: "http://localhost:5001/api/callback"
						approved: true
	hooks:
		beforeCreate: (client, options) ->
			unencrypted = client.clientSecret
			salt = uuid.v4()
			encrypted = crypto.aes unencrypted, salt, secret
			client.clientSecret = encrypted
			client.salt = salt
		beforeUpdate: (client, options) ->
			unencrypted = client.clientSecret
			if !!unencrypted
				salt = uuid.v4()
				encrypted = crypto.aes unencrypted, salt, secret
				client.clientSecret = encrypted
				client.salt = salt
		afterFind: (client, options) ->
			if !client then return client
			clientSecret = client.clientSecret
			salt = client.salt
			unencrypted = crypto.unaes clientSecret, salt, secret
			client.clientSecret = unencrypted
}

module.exports = Clients

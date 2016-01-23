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
	clientId:
		type: Seq.STRING
		allowNull: false
		unique: true
		validate:
			isAlphanumeric: true
			notEmpty: true
	clientName:
		type: Seq.STRING
		allowNull: false
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
		validate:
			isUrl: true
			notEmpty: true,
} , {
	classMethods:
		_compareSecrets: (fromUser, fromDatabase, salt) ->
			encrypted = crypto.aes fromUser, salt, secret
			return encrypted is fromDatabase
		_dummy: ->
			Clients.create
				clientId: "bestapp"
				clientName: "BestApp"
				clientSecret: "secret"
				redirectUri: "localhost"
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
			clientSecret = client.clientSecret
			salt = client.salt
			unencrypted = crypto.unaes clientSecret, salt, secret
			client.clientSecret = unencrypted
}

### TODO
Add records with "approved: false". I should approve clients before they
can actually access the API.
###

module.exports = Clients

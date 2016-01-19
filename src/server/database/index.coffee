index =
	users: require "./UserService.js"
	clients: require "./ClientService.js"
	accessTokens: require "./AccessTokenService.js"
	authorizationCodes: require "./AuthorizationCodeService.js"
	AccessTokens: require "./AccessTokens.js"
	AuthCodes: require "./AuthCodes.js"
	Clients: require "./Clients.js"
	Users: require "./Users.js"

# TODO Get rid of old stubbed db services. Will use sequelize models.

module.exports = index

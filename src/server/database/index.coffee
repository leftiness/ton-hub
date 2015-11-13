index =
	users: require "./UserService.js"
	clients: require "./ClientService.js"
	accessTokens: require "./AccessTokenService.js"
	authorizationCodes: require "./AuthorizationCodeService.js"

module.exports = index

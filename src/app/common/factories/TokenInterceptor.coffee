interceptor = (UserService) ->
	_ =
		request: (config) ->
			token = UserService.user?.token
			if token then config.headers.Authorization = "Bearer #{token}"
			return config

interceptor.$inject = ["UserService"];

module.exports = interceptor;

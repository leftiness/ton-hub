service = ($state, $mdToast, Restangular, UserService, SettingsService) ->
	self = this
	self.callback = (params) ->
		okCallback = (res) ->
			token = res.access_token
			type = res.token_type
			if type is "Bearer"
				UserService.user.token = token
				SettingsService.getSettings()
			else
				note = "Token type not recognized. Authorization failed. Type: #{type}"
				toast = $mdToast.simple()
					.content note
					.position "top right"
			$state.go "home"
		koCallback = (res) ->
			toast = $mdToast.simple()
				.content "Failed callback. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		Restangular.all("callback").post(params).then okCallback, koCallback
	self

service.$inject = [
	"$state"
	"$mdToast"
	"Restangular"
	"UserService"
	"SettingsService"
]

module.exports = service;

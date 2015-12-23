LoginService = ($state, $mdToast, Restangular, SettingsService, UserService) ->
	self = this
	self.login = (json) ->
		rest = Restangular.all "login"
		okLogin = (res) ->
			UserService.user.username = json.username
			state = res.data?.state || "home"
			params = res.data?.params || {}
			$state.go state, params
		koLogin = (res) ->
			toast = $mdToast.simple()
				.content "Failed to log in. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		rest.post(json).then okLogin, koLogin
	self.logout = ->
		UserService.user = {} #TODO Stubbed. Have to tell the serer to invalidate session.
	self

LoginService.$inject = [
	"$state"
	"$mdToast"
	"Restangular"
	"SettingsService"
	"UserService"
]

module.exports = LoginService

LoginService = ($state, $mdToast, Restangular, SettingsService) ->
	self = this
	self.user = {}
	self.login = (json) ->
		rest = Restangular.all "login"
		okLogin = (res) ->
			self.user["username"] = json.username
			$state.go "home"
		koLogin = (res) ->
			toast = $mdToast.simple()
				.content "Failed to log in. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		rest.post(json).then okLogin, koLogin
	self.logout = ->
		self.user = {} #TODO Stubbed. Have to tell the serer to invalidate session.
	self

LoginService.$inject = ["$state", "$mdToast", "Restangular", "SettingsService"];

module.exports = LoginService;

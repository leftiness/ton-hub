service = ($state, $mdToast, Restangular) ->
	self = this
	self.signup = (json) ->
		rest = Restangular.all "signup"
		okSignup = (res) ->
			toast = $mdToast.simple()
				.content "Check your email for an activation link."
				.position "top right"
			$mdToast.show toast
			$state.go "home"
		koSignup = (res) ->
			toast = $mdToast.simple()
				.content "Failed to sign up. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		rest.post(json).then okSignup, koSignup
	self

service.$inject = ["$state", "$mdToast", "Restangular"];

module.exports = service;

service = ($mdToast, Restangular, UserService) ->
	self = this
	self.logout = () ->
		rest = Restangular.all "logout"
		okLogout = ->
			UserService.user = {}
		koLogout = ->
			toast = $mdToast.simple()
				.content "Failed to logout. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		rest.get("").then okLogout, koLogout
	self

service.$inject = ["$mdToast", "Restangular", "UserService"];

module.exports = service;

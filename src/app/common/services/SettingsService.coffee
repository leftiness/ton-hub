SettingsService = ($mdToast, Restangular) ->
	self = this
	rest = Restangular.one("settings")
	self.settings =
		name: "Anon"
	self.getSettings = ->
		# TODO This will be updated when I write the /callback module.
		# It needs to get called from that module and use a provided bearer token.
		okGet = (res) ->
			self.settings = res.data
		koGet = (res) ->
			toast = $mdToast.simple()
				.content "Failed to get settings. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		rest.get().then okGet, koGet
	self.postSettings = (json) ->
		okPost = (res) ->
			for own key, value of json
				self.settings[key] = value
			toast = $mdToast.simple()
				.content "Settings saved."
				.position "top right"
			$mdToast.show toast
		koPost = (res) ->
			toast = $mdToast.simple()
				.content "Failed to post settings. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		rest.customPOST(json).then okPost, koPost
	self

SettingsService.$inject = ["$mdToast", "Restangular"];

module.exports = SettingsService;

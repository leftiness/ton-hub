service = ($state, $mdToast, Restangular) ->
	self = this
	post = (id, accept) ->
		rest = Restangular.all "decision"
		json =
			transaction_id: id
			cancel: !accept
		okPost = (res) ->
			# TODO Get the token. Store it somewhere. Load user information. Etc.
			# token = res.data.token
			$state.go "home"
		koPost = (res) ->
			toast = $mdToast.simple()
				.content "Failed to authorize. Reason: #{res.data.reason}"
				.position "top right"
			$mdToast.show toast
		return rest.post json
			.then okPost, koPost
	self.accept = (id) -> post id, true
	self.deny = (id) -> post id, false
	self

service.$inject = ["$state", "$mdToast", "Restangular"];

module.exports = service;

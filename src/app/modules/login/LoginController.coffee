LoginCtrl = ($stateParams, $mdToast) ->
	"use strict"
	self = this
	err = $stateParams.error
	if err
		toast = $mdToast.simple()
			.content "Failed to login. Reason: #{err}"
			.position "top right"
		$mdToast.show toast
	self

LoginCtrl.$inject = ["$stateParams", "$mdToast"]

module.exports = LoginCtrl

ctrl = ($stateParams, CallbackService) ->
	"use strict"
	self = this
	code = $stateParams.code
	CallbackService.callback code
	return self

ctrl.$inject = ["$stateParams", "CallbackService"]

module.exports = ctrl

ctrl = ($stateParams, CallbackService) ->
	"use strict"
	self = this
	CallbackService.callback $stateParams
	return self

ctrl.$inject = ["$stateParams", "CallbackService"]

module.exports = ctrl

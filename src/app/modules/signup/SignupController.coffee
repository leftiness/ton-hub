SignupController = (SignupService) ->
	"use strict"
	self = this
	self.user = {}
	self.signup = ->
		SignupService.signup self.user
	self

SignupController.$inject = ["SignupService"]

module.exports = SignupController

SignupController = (LoginService) ->
	"use strict"
	self = this
	self.user = {}
	self.signup = ->
		LoginService.signup self.user
	self

SignupController.$inject = ["LoginService"]

module.exports = SignupController

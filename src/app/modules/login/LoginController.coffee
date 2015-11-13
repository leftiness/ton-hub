LoginCtrl = (LoginService) ->
	"use strict"
	self = this
	self.user = {}
	self.login = ->
		LoginService.login self.user
	self

LoginCtrl.$inject = ["LoginService"]

module.exports = LoginCtrl

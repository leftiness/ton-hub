ctrl = ($stateParams, AuthorizeService) ->
	"use strict"
	self = this
	self.id = $stateParams.id
	self.client = $stateParams.client
	self.accept = -> AuthorizeService.accept id
	self.deny = -> AuthorizeService.deny id
	return self

ctrl.$inject = ["$stateParams", "AuthorizeService"]

module.exports = ctrl

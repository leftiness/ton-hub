ctrl = ($stateParams, $cookies) ->
	"use strict"
	self = this
	self.id = $stateParams.id
	self.client = $stateParams.client
	self.xsrf = $cookies.get "xsrf"
	return self

ctrl.$inject = ["$stateParams", "$cookies"]

module.exports = ctrl

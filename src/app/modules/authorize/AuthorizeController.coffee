ctrl = ($stateParams) ->
	"use strict"
	self = this
	self.id = $stateParams.id
	self.client = $stateParams.client
	return self

ctrl.$inject = ["$stateParams"]

module.exports = ctrl

ctrl = ($stateParams) ->
	"use strict"
	self = this
	self.id = $stateParams.id
	return self

ctrl.$inject = ["$stateParams"]

module.exports = ctrl

ctrl = ($stateParams) ->
	"use strict"
	self = this
	self.id = $stateParams.id

ctrl.$inject = ["$stateParams"]

module.exports = ctrl

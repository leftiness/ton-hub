HomeCtrl = (UserService, LoadingService) ->
	"use strict"
	self = this
	self.user = UserService
	self.startLoading = ->
		# Obviously this function should be removed. It's just a demo.
		LoadingService.start()
	self.stopLoading = ->
		# Obviously this function should be removed. It's just a demo.
		LoadingService.stop()
	self

HomeCtrl.$inject = ["UserService", "LoadingService"]

module.exports = HomeCtrl

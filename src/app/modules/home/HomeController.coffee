HomeCtrl = (LoginService, LoadingService) ->
	"use strict"
	self = this
	self.login = LoginService
	self.startLoading = ->
		# Obviously this function should be removed. It's just a demo.
		LoadingService.start()
	self.stopLoading = ->
		# Obviously this function should be removed. It's just a demo.
		LoadingService.stop()
	self

HomeCtrl.$inject = ["LoginService", "LoadingService"]

module.exports = HomeCtrl

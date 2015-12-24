HeaderCtrl = ($mdSidenav, $mdMedia, UserService, LogoutService) ->
	"use strict"
	self = this
	self.$mdSidenav = $mdSidenav
	self.$mdMedia = $mdMedia
	self.user = UserService
	self.logout = LogoutService.logout()
	self

HeaderCtrl.$inject = ["$mdSidenav", "$mdMedia", "UserService", "LogoutService"]

module.exports = HeaderCtrl

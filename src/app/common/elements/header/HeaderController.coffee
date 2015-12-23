HeaderCtrl = ($mdSidenav, $mdMedia, LoginService, UserService) ->
	"use strict"
	self = this
	self.$mdSidenav = $mdSidenav
	self.$mdMedia = $mdMedia
	self.login = LoginService
	self.user = UserService
	self

HeaderCtrl.$inject = ["$mdSidenav", "$mdMedia", "LoginService", "UserService"]

module.exports = HeaderCtrl

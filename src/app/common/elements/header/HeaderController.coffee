HeaderCtrl = ($mdSidenav, $mdMedia, UserService, LogoutService, LoginService) ->
	"use strict"
	self = this
	self.$mdSidenav = $mdSidenav
	self.$mdMedia = $mdMedia
	self.user = UserService
	self.logout = LogoutService.logout
	self.login = LoginService.login
	self

HeaderCtrl.$inject = [
	"$mdSidenav"
	"$mdMedia"
	"UserService"
	"LogoutService"
	"LoginService"
]

module.exports = HeaderCtrl

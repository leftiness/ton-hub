HeaderCtrl = ($window, $mdSidenav, $mdMedia, UserService, LogoutService) ->
	"use strict"
	self = this
	self.$mdSidenav = $mdSidenav
	self.$mdMedia = $mdMedia
	self.user = UserService
	self.logout = LogoutService.logout
	self.login = () ->
		url = "/api/login"
		name = "_blank"
		specs = "height=400,menubar=no,scrollbars=no,statusbar=no,titlebar=no"
		specs += "toolbar=no,width=300"
		$window.open url, name, specs
	self

HeaderCtrl.$inject = [
	"$window"
	"$mdSidenav"
	"$mdMedia"
	"UserService"
	"LogoutService"
]

module.exports = HeaderCtrl

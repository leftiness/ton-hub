SidenavCtrl = ($mdMedia, $mdSidenav, $state, LoginService, SettingsService) ->
	"use strict"
	self = this
	self.items = [
		_ =
			name: "Home"
			sref: "home"
		_ =
			name: "About"
			sref: "about"
		_ =
			name: "Download"
			sref: "download"
	]
	self.$mdMedia = $mdMedia
	self.$mdSidenav = $mdSidenav
	self.login = LoginService
	self.set = SettingsService
	self.clickSettingsButton = ->
		user = LoginService.user
		if user.username
			params =
				id: user.id
				view: "posts"
			$state.go "settings", params
		else
			$state.go "login"
		$mdSidenav("sidenav").close()
	self

SidenavCtrl.$inject = [
	"$mdMedia"
	"$mdSidenav"
	"$state"
	"LoginService"
	"SettingsService"
]

module.exports = SidenavCtrl

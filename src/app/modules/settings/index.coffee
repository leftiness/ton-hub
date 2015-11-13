module.exports = angular.module "modules.settings", []
	.config require "./settingsRoutes.coffee"
	.directive "settingsView", require "./settingsDirective.coffee"
	.controller "SettingsCtrl", require "./SettingsController.coffee"

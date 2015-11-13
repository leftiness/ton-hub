module.exports = angular.module "common.services", []
	.service "LoginService", require "./LoginService.coffee"
	.service "LoadingService", require "./LoadingService.coffee"
	.service "ActionsService", require "./ActionsService.coffee"
	.service "SettingsService", require "./SettingsService.coffee"

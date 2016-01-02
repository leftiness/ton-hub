module.exports = angular.module "common.services", []
	.service "SignupService", require "./SignupService.coffee"
	.service "LoadingService", require "./LoadingService.coffee"
	.service "ActionsService", require "./ActionsService.coffee"
	.service "SettingsService", require "./SettingsService.coffee"
	.service "CallbackService", require "./CallbackService.coffee"
	.service "UserService", require "./UserService.coffee"
	.service "LogoutService", require "./LogoutService.coffee"
	.service "LoginService", require "./LoginService.coffee"

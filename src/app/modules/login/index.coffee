module.exports = angular.module "modules.login", []
	.config require "./loginRoutes.coffee"
	.directive "loginView", require "./loginDirective.coffee"
	.controller "LoginCtrl", require "./LoginController.coffee"

module.exports = angular.module "modules.authorize", []
	.config require "./authorizeRoutes.coffee"
	.directive "authorizeView", require "./authorizeDirective.coffee"
	.controller "AuthorizeCtrl", require "./AuthorizeController.coffee"

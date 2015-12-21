module.exports = angular.module "modules.error", []
	.config require "./errorRoutes.coffee"
	.directive "errorView", require "./errorDirective.coffee"
	.controller "ErrorCtrl", require "./ErrorController.coffee"

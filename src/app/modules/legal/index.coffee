module.exports = angular.module "modules.legal", []
	.config require "./legalRoutes.coffee"
	.directive "legalView", require "./legalDirective.coffee"

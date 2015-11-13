module.exports = angular.module "modules.download", []
	.config require "./downloadRoutes.coffee"
	.directive "downloadView", require "./downloadDirective.coffee"

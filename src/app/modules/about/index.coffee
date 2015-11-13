module.exports = angular.module "modules.about", []
	.config require "./aboutRoutes.coffee"
	.directive "aboutView", require "./aboutDirective.coffee"
	.controller "AboutCtrl", require "./AboutController.coffee"

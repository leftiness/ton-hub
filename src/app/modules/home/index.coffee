module.exports = angular.module "modules.home", []
	.config require "./homeRoutes.coffee"
	.directive "homeView", require "./homeDirective.coffee"
	.controller "HomeCtrl", require "./HomeController.coffee"

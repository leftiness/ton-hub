module.exports = angular.module "modules.recover", []
	.config require "./recoverRoutes.coffee"
	.directive "recoverView", require "./recoverDirective.coffee"
	.controller "RecoverCtrl", require "./RecoverController.coffee"

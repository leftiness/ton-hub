module.exports = angular.module "modules.callback", []
	.config require "./callbackRoutes.coffee"
	.directive "callbackView", require "./callbackDirective.coffee"
	.controller "CallbackCtrl", require "./CallbackController.coffee"

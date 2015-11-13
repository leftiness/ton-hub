module.exports = angular.module "common.elements.commonActions", []
	.directive "commonActions", require "./actionsDirective.coffee"
	.controller "ActionsCtrl", require "./ActionsController.coffee"

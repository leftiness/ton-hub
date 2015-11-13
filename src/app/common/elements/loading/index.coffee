module.exports = angular.module "common.elements.commonLoading", []
	.directive "commonLoading", require "./loadingDirective.coffee"
	.controller "LoadingCtrl", require "./LoadingController.coffee"

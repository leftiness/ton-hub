module.exports = angular.module "common.elements.commonHeader", []
	.directive "commonHeader", require "./headerDirective.coffee"
	.controller "HeaderCtrl", require "./HeaderController.coffee"

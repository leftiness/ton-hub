module.exports = angular.module "common.elements.commonSidenav", []
	.directive "commonSidenav", require "./sidenavDirective.coffee"
	.controller "SidenavCtrl", require "./SidenavController.coffee"

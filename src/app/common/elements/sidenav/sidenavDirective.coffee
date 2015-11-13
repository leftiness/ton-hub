module.exports = ->
	"use strict"
	sidenavDirective =
		controller: "SidenavCtrl as nav"
		template: require "./common-sidenav.jade"
		restrict: "EA"
		replace: true

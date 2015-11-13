module.exports = ->
	"use strict"
	aboutDirective =
		controller: "AboutCtrl as about"
		template: require "./about.jade"
		restrict: "EA"
		scope: true

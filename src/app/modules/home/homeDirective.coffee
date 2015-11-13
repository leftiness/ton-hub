module.exports = ->
	"use strict"
	homeDirective =
		controller: "HomeCtrl as home"
		template: require "./home.jade"
		restrict: "EA"
		scope: true

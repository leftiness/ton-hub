module.exports = ->
	"use strict"
	headerDirective =
		controller: "HeaderCtrl as header"
		template: require "./common-header.jade"
		restrict: "EA"
		replace: true

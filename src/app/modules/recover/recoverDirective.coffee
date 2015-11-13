module.exports = ->
	"use strict"
	recoverDirective =
		controller: "RecoverCtrl as recover"
		template: require "./recover.jade"
		restrict: "EA"
		scope: true

module.exports = ->
	"use strict"
	actionsDirective =
		controller: "ActionsCtrl as actions"
		template: require "./common-actions.jade"
		restrict: "EA"
		replace: true

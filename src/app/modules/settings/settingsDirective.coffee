module.exports = ->
	"use strict"
	settingsDirective =
		controller: "SettingsCtrl as set"
		template: require "./settings.jade"
		restrict: "EA"
		scope: true

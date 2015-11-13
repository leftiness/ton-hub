module.exports = ->
	"use strict"
	loginDirective =
		controller: "LoginCtrl as login"
		template: require "./login.jade"
		restrict: "EA"
		scope: true

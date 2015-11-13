module.exports = ->
	"use strict"
	signupDirective =
		controller: "SignupCtrl as signup"
		template: require "./signup.jade"
		restrict: "EA"
		scope: true

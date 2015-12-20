module.exports = ->
	"use strict"
	directive =
		controller: "AuthorizeCtrl as auth"
		template: require "./authorize.jade"
		restrict: "EA"
		scope: true

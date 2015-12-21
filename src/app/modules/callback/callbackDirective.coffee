module.exports = ->
	"use strict"
	directive =
		controller: "CallbackCtrl as callback"
		template: require "./callback.jade"
		restrict: "EA"
		scope: true

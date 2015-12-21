module.exports = ->
	"use strict"
	directive =
		controller: "ErrorCtrl as error"
		template: require "./error.jade"
		restrict: "EA"
		scope: true

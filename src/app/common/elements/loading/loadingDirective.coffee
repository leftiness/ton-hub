module.exports = ->
	"use strict"
	loadingDirective =
		controller: "LoadingCtrl as loading"
		template: require "./common-loading.jade"
		restrict: "EA"

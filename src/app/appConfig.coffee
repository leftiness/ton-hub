appConfig = ($urlRouterProvider, $locationProvider) ->
	"use strict"
	$locationProvider.html5Mode(true).hashPrefix "!"
	$urlRouterProvider.otherwise "/"

appConfig.$inject = ["$urlRouterProvider", "$locationProvider"]

module.exports = appConfig

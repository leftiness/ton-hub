appConfig = ($urlRouterProvider, $locationProvider, $httpProvider) ->
	"use strict"
	$locationProvider.html5Mode(true).hashPrefix "!"
	$urlRouterProvider.otherwise "/"

appConfig.$inject = ["$urlRouterProvider", "$locationProvider", "$httpProvider"]

module.exports = appConfig

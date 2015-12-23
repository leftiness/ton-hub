appConfig = ($urlRouterProvider, $locationProvider, $httpProvider) ->
	"use strict"
	$locationProvider.html5Mode(true).hashPrefix "!"
	$urlRouterProvider.otherwise "/"
	$httpProvider.interceptors.push "TokenInterceptor"

appConfig.$inject = ["$urlRouterProvider", "$locationProvider", "$httpProvider"]

module.exports = appConfig

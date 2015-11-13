commonInit = ($rootScope, $state) ->
	"use strict"
	$rootScope.$state = $state

	$rootScope.$on "$stateChangeSuccess", (event, toState) ->
		if (angular.isDefined toState.data.pageTitle)
			$rootScope.pageTitle = toState.data.pageTitle
			$rootScope.pageDescription = toState.data.pageDescription
			$rootScope.bodyClasses = toState.data.moduleClasses + ' ' + toState.data.pageClasses
			$rootScope.hasActions = toState.data.hasActions

	$rootScope.$on "$viewContentLoaded", ->
		if (document.readyState is "complete")
			window.scrollTo 0, 0

	$rootScope.emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

commonInit.$inject = ["$rootScope", "$state"]

module.exports = commonInit

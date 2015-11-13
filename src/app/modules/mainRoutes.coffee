mainRoutes = ($stateProvider) ->
	'use strict'
	main =
		name: "main"
		abstract: "true"
		url: "/"
		template: "<div ui-view></div>"
		controller: "MainCtrl as main"

	$stateProvider.state main

mainRoutes.$inject = ["$stateProvider"]

module.exports = mainRoutes

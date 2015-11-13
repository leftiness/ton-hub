recoverRoutes = ($stateProvider) ->
	"use strict"
	recover =
		name: "recover"
		parent: "main"
		url: "^/recover"
		template: "<div recover-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "recover"
			pageTitle: "Recover"
			pageDescription: "Meta Description goes here"

	$stateProvider.state recover

recoverRoutes.$inject = ["$stateProvider"]

module.exports = recoverRoutes

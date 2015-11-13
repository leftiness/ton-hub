legalRoutes = ($stateProvider) ->
	"use strict"
	legal =
		name: "legal"
		parent: "main"
		url: "^/legal"
		template: "<div legal-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "legal"
			pageTitle: "Legal"
			pageDescription: "Meta Description goes here"

	$stateProvider.state legal

legalRoutes.$inject = ["$stateProvider"]

module.exports = legalRoutes

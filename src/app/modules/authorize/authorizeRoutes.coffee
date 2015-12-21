routes = ($stateProvider) ->
	"use strict"
	authorize =
		name: "authorize"
		parent: "main"
		url: "^/authorize?id&client"
		template: "<div authorize-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "authorize"
			pageTitle: "Authorize"
			pageDescription: "Meta Description goes here"

	$stateProvider.state authorize

routes.$inject = ["$stateProvider"]

module.exports = routes

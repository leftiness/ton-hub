aboutRoutes = ($stateProvider) ->
	"use strict"
	about =
		name: "about"
		parent: "main"
		url: "^/about"
		template: "<div about-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "about"
			pageTitle: "About"
			pageDescription: "Meta Description goes here"

	$stateProvider.state about

aboutRoutes.$inject = ["$stateProvider"]

module.exports = aboutRoutes

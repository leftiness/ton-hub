settingsRoutes = ($stateProvider) ->
	"use strict"
	settings =
		name: "settings"
		parent: "main"
		url: "^/settings"
		template: "<div settings-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "settings"
			pageTitle: "Settings"
			pageDescription: "Meta Description goes here"

	$stateProvider.state settings

settingsRoutes.$inject = ["$stateProvider"]

module.exports = settingsRoutes

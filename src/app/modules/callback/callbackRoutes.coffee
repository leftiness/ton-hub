routes = ($stateProvider) ->
	"use strict"
	callback =
		name: "callback"
		parent: "main"
		url: "^/callback"
		template: "<div callback-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "callback"
			pageTitle: "Callback"
			pageDescription: "Meta Description goes here"

	$stateProvider.state callback

routes.$inject = ["$stateProvider"]

module.exports = routes
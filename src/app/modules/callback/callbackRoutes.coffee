routes = ($stateProvider) ->
	"use strict"
	callback =
		name: "callback"
		parent: "main"
		url: "^/callback?code?state?error?error_description"
		template: "<div callback-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "callback"
			pageTitle: ""
			pageDescription: "Meta Description goes here"

	$stateProvider.state callback

routes.$inject = ["$stateProvider"]

module.exports = routes

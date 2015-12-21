routes = ($stateProvider) ->
	"use strict"
	error =
		name: "error"
		parent: "main"
		url: "^/error?id"
		template: "<div error-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "error"
			pageTitle: "Error"
			pageDescription: "Meta Description goes here"

	$stateProvider.state error

routes.$inject = ["$stateProvider"]

module.exports = routes

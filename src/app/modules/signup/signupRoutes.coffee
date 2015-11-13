signupRoutes = ($stateProvider) ->
	"use strict"
	signup =
		name: "signup"
		parent: "main"
		url: "^/signup"
		template: "<div signup-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "signup"
			pageTitle: "Sign up"
			pageDescription: "Meta Description goes here"

	$stateProvider.state signup

signupRoutes.$inject = ["$stateProvider"]

module.exports = signupRoutes

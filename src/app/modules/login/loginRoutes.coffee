loginRoutes = ($stateProvider) ->
	"use strict"
	login =
		name: "login"
		parent: "main"
		url: "^/login"
		template: "<div login-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "login"
			pageTitle: "Login"
			pageDescription: "Meta Description goes here"

	$stateProvider.state login

loginRoutes.$inject = ["$stateProvider"]

module.exports = loginRoutes

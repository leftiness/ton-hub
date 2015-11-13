downloadRoutes = ($stateProvider) ->
	"use strict"
	download =
		name: "download"
		parent: "main"
		url: "^/download"
		template: "<div download-view></div>"
		data:
			moduleClasses: "page"
			pageClasses: "download"
			pageTitle: "Download"
			pageDescription: "Meta Description goes here"

	$stateProvider.state download

downloadRoutes.$inject = ["$stateProvider"]

module.exports = downloadRoutes

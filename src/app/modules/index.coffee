module.exports = angular.module "modules", [
		require("./home/index.coffee").name
		require("./about/index.coffee").name
		require("./signup/index.coffee").name
		require("./legal/index.coffee").name
		require("./recover/index.coffee").name
		require("./download/index.coffee").name
		require("./settings/index.coffee").name
		require("./error/index.coffee").name
	]
	.config require "./mainRoutes.coffee"
	.controller "MainCtrl", require "./MainController.coffee"

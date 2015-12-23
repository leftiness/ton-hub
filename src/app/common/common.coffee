window._ = require "lodash"

require "angular-ui-router"
require "angular-animate"
require "angular-cookies"
require "angular-resource"
require "angular-sanitize"
require "lodash"
require "restangular"
require "angular-aria"
require "angular-animate"
require "angular-material"

module.exports = angular.module "common", [
		"ui.router"
		"ngAnimate"
		"ngCookies"
		"ngResource"
		"ngSanitize"
		"restangular"
		"ngMaterial"
		require("./constants/index.coffee").name
		require("./directives/index.coffee").name
		require("./elements/header/index.coffee").name
		require("./elements/sidenav/index.coffee").name
		require("./elements/loading/index.coffee").name
		require("./elements/actions/index.coffee").name
		require("./services/index.coffee").name
		require("./factories/index.coffee").name
	]

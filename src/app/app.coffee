require "angular"

module.exports = angular.module "ton-social", [
		require("./common/common.coffee").name
		require("./modules/index.coffee").name
	]
	.config require "./appConfig.coffee"
	.config require "./restangularConfig.coffee"
	.constant "version", require("../../package.json").version
	.run require "./common/common-init.coffee"

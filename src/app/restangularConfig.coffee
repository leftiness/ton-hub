config = (RestangularProvider) ->
	"use strict"
	RestangularProvider.setBaseUrl "/api"

config.$inject = ["RestangularProvider"]

module.exports = config

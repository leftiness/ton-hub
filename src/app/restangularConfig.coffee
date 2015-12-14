config = (RestangularProvider) ->
	"use strict"
	RestangularProvider.setBaseUrl "/api/local"

config.$inject = ["RestangularProvider"]

module.exports = config

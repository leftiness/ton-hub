LoadingCtrl = (LoadingService) ->
	"use strict"
	self = this
	self.service = LoadingService
	self

LoadingCtrl.$inject = ["LoadingService"]

module.exports = LoadingCtrl

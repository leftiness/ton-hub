SettingsCtrl = (SettingsService) ->
	"use strict"
	self = this
	self.settings = undefined
	SettingsService.getSettings().then ->
		self.settings = SettingsService.settings
	self.submit = ->
		SettingsService.postSettings self.settings
	self

SettingsCtrl.$inject = ["SettingsService"]

module.exports = SettingsCtrl

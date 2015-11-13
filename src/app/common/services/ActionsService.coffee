ActionsService = () ->
	self = this
	self.actions = []
	self.init = (actions) ->
		self.actions = actions
	self

ActionsService.$inject = [];

module.exports = ActionsService;

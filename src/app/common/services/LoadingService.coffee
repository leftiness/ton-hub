LoadingService = ($timeout) ->
	self = this
	self.loading = false
	self.start = ->
		self.loading = true
	self.stop = ->
		fn = -> self.loading = false
		$timeout fn, 1000
	self

LoadingService.$inject = ["$timeout"];

module.exports = LoadingService;

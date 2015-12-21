service = (Restangular) ->
	self = this
	post = (id, cancel) ->
		rest = Restangular.all "decision"
		json =
			transaction_id: id
			cancel: cancel
		rest.post json
	self.accept = (id) -> post id, false
	self.deny = (id) -> post id, true
	self

service.$inject = ["Restangular"];

module.exports = service;

service = (Restangular) ->
	self = this
	post = (id, accept) ->
		rest = Restangular.all "decision"
		json =
			transaction_id: id
			cancel: !accept
		return rest.post json
	self.accept = (id) -> post id, true
	self.deny = (id) -> post id, false
	self

service.$inject = ["Restangular"];

module.exports = service;

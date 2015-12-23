service = ->
	self = this
	_token = ""
	self.token = (token) ->
		if token is undefined then return _token
		else _token = token
	self

service.$inject = [];

module.exports = service;

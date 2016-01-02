_popup = undefined
_id = undefined

service = ($window, $mdToast, Restangular) ->
	self = this
	self.login = ->
		if _popup and !_popup.closed then _popup.close()
		if _id then $window.clearInterval _id
		url = "/api/login"
		name = "_blank"
		json =
			height: 400
			width: 300
			menubar: "no"
			scrollbars: "no"
			statusbar: "no"
			titlebar: "no"
			toolbar: "no"
		specs = ""
		specs += "#{k}=#{v}," for own k, v of json
		_popup = $window.open url, name, specs
		onClose = ->
			if _popup.closed
				alert "Closed"
				### TODO
				Last check. Get identity of token. Confirm identity to enable token.
				If you GET /api/identity fails because 401, then authentication failed.
				Give toast. If it succeeds, ask the user if they want to confirm the
				identity of the ton account that is about to be authorized. If they
				confirm, mark the token in the db as confirmed. If they deny, delete
				the token.
				###
				$window.clearInterval _id
		_id = $window.setInterval onClose, 500
	self

service.$inject = ["$window", "$mdToast", "Restangular"];

module.exports = service;

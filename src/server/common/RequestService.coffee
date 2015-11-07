q = require "q"
qs = require "querystring"
req = require "request"

RequestService = (url) ->
	service =
		request: (verb, path, query) ->
			string = qs.stringify query
			full = "#{url}#{path}?#{string}"
			conf =
				method: verb
				uri: full
			q.Promise (resolve, reject, notify) ->
				wait = 5000
				timeout =
					status: 504
					reason: "#{verb} request to #{full} timed out after #{wait} ms"
				setTimeout reject, wait, timeout
				req conf, (error, response, body) ->
					if error
						err =
							status: 500
							reason: error
						reject err
					else
						res =
							response: response
							body: body
							status: response.statusCode
						resolve res

module.exports = RequestService

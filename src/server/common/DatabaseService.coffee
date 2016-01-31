models = require "../database/index.js"

env = process.env.NODE_ENV || "development"

service =
	init: ->
		array = (model for own name, model of models)
		return Promise.all array.map (model) ->
				return model.sync()
			.then ->
				dev = env is "development"
				return Promise.all array.map (model) ->
					return model._dummy?() if dev?

module.exports = service

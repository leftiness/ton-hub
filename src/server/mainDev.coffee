pm2 = require "pm2"

pm2.connect ->
	conf =
		script: "./dist/server.js"
		name: "ton-hub"
		env:
			NODE_ENV: "development"
	pm2.start conf, (err) ->
		if err
			console.error "Error while launching applications", err.stack || err
			return
		console.log "pm2 and application have been successfully started"
		pm2.launchBus (err, bus) ->
			console.log "[pm2] Log streaming started"
			bus.on "log:out", (packet) ->
				console.log "[App:#{packet.process.name}] #{packet.data}"
			bus.on "log:err", (packet) ->
				console.error "[App:#{packet.process.name}][Err] #{packet.data}"

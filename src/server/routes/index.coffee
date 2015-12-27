routes = [
	require "./post/login.js"
	require "./get/teapot.js"
	require "./get/settings.js"
	require "./get/authorize.js"
	require "./get/logout.js"
	require "./post/callback.js"
	require "./post/settings.js"
	require "./post/signup.js"
	require "./post/decision.js"
	require "./post/token.js"
]

module.exports = routes

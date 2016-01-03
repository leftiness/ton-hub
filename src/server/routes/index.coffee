routes = [
	require "./get/authorize.js"
	require "./get/confirm.js"
	require "./get/login.js"
	require "./get/logout.js"
	require "./get/settings.js"
	require "./get/teapot.js"
	require "./post/decision.js"
	require "./post/login.js"
	require "./post/settings.js"
	require "./post/signup.js"
	require "./post/token.js"
]

module.exports = routes

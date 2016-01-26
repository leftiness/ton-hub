routes = [
	require "./get/activate_account.js"
	require "./get/authorize.js"
	require "./get/confirm.js"
	require "./get/identity.js"
	require "./get/login.js"
	require "./get/logout.js"
	require "./get/register_account.js"
	require "./get/settings.js"
	require "./get/teapot.js"
	require "./post/activate_account.js"
	require "./post/decision.js"
	require "./post/identity.js"
	require "./post/login.js"
	require "./post/register_account.js"
	require "./post/settings.js"
	require "./post/token.js"
]

module.exports = routes

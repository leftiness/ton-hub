###
As you can see, this is an example of what is required in secrets.coffee.
Fill this up with valid values, and ton-hub can work.
###

secrets =
	oauth2:
		client_id: "BestApp"
		client_secret: "verysecret"
		redirect_uri: "http://www.bestapp.com/callback"

module.exports = secrets

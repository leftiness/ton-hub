route =
	verb: "get"
	path: "/teapot"
	fn: (req, res) ->
		res.status(418).send """
			<html>
			<head>
			<meta name="viewport" content="width=device-width, maximum-scale=1.0">
			</head>
			<body><pre>
			                       (
			            _           ) )
			         _,(_)._        ((
			    ___,(_______).        )
			  ,'__.   /       \\    /\\_
			 /,' /  |""|       \\  /  /
			| | |   |__|       |,'  /
			 \\`.|                  /
			  `. :           :    /
			    `.            :.,'
			      `-.________,-'

			FORCED TO RESPOND 418 BECAUSE I AM A TEAPOT
			</pre></body>
			</html>
			"""

module.exports = route

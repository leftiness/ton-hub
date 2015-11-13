module.exports = angular.module "modules.signup", []
	.config require "./signupRoutes.coffee"
	.directive "signupView", require "./signupDirective.coffee"
	.controller "SignupCtrl", require "./SignupController.coffee"

angular.module('myApp')
.controller('SignupController', ['$scope','$http','$state', function($scope, $http, $state){
	$scope.statelist = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"];
	$scope.err =false;
	
	$scope.restaurant = {
		'name': '',
		'username':'',
		'phone':'',
		'email':'',
		'password':'',
		'street':'',
		'city':'',
		'state':''
	};


	

	$scope.signupRes = function(restaurant){
		$http.post('api/restaurant/signup', restaurant)
		.success(function(callback){
			console.log(callback);
			$state.go('login');
		}).error(function(err){
			console.log(err)
		})
	}
	
}]);
angular.module('myApp')
.controller('LoginController', ['$scope','$http','$state','$interval', function($scope, $http, $state, $interval){
	$scope.callback = '';
	$scope.user = {
		'username': '',
		'password':''
	};
	$scope.login = 'Login Page';
	$interval(function(){
		console.log('searching for an external user');
		if($scope.watchUser) {
			
	$http({
	  method: 'GET',
	  url: '/callbackSuccess'
	}).then(function successCallback(response) {
		$scope.watchUser = response.data;
	    localStorage.setItem('User-Data', JSON.stringify(response.data));
		$state.go('users_home');
	  }, function errorCallback(response) {
	    console.log('error');
  	});
		}
	
	},3000);
	

	$scope.login = function(form) {
		if(!form.$invalid) {
			$http.post('api/user/login', $scope.user)
			.success(function(callback){
				if(callback.res == 'error') {
					$scope.callback = callback.data;
				}
				else if(callback.res == 'success') {
					$scope.callback = '';
					callback.data.type = "user";
					localStorage.setItem('User-Data', JSON.stringify(callback.data));
					$state.go('users_home');
				}
				console.log(callback);
			}).error(function(err){
				$scope.callback = err.data;
				console.log(err);
			})
		}
	}

	$scope.loginRest = function(form) {
		if(!form.$invalid) {
			$http.post('api/restaurant/login', $scope.user)
			.success(function(callback){
				if(callback.res == 'error') {
					$scope.callback = callback.data;
				}
				else if(callback.res == 'success') {
					$scope.callback = '';
					callback.data.type = "restaurant";
					localStorage.setItem('User-Data', JSON.stringify(callback.data));
					$state.go('restaurant_home');
				}
				console.log(callback);
			}).error(function(err){
				$scope.callback = err.data;
				console.log(err);
			})
		}
	}
	
}]);
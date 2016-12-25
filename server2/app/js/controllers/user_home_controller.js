angular.module('myApp')
.controller('UsersHomeController', ['$scope','$http','$state', function($scope, $http, $state){
    
	$scope.statelist = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"];
    $scope.dishTypes = ["","Main dish","Salads","Soups","Appetizers/Starters","Entrée","Pasta & Noodles","Pizzas","Desserts","Beverages","Kids Menu","Burger/Sandwiches","Seafood"];
    $scope.cuisines = ["","American","African","British","Caribbean","Chinese","French","Greek","Indian","Italian","Japenese","Mediterranean","Mexican","Moroccan","Spanish","Thai","Turkish","Vietamese"];

    $scope.searchList = 
        {
        	city: 'NYC',
            state: 'New York',
            budget: 0,
            people: 0,
            foodName: '',
            cuisine: '',
            foodType: ''
         };
$scope.menuItems = [];


	$scope.submit = function() { 
        $http.post('api/restaurant/search', $scope.searchList)
			.success(function(callback){
				if(callback.res == 'error') {
					$scope.callback = callback.data;
				}
				else if(callback.res == 'success') {
					$scope.menuItems = callback.data;
				}
				console.log(callback);
			}).error(function(err){
				$scope.callback = err.data;
				console.log(err);
			})
     };

	$scope.restoInfo = function(restID){
		$state.go('restaurant_formatted_menu', {idRest: restID});
	}
$scope.search = function(item){
    if (
(item.itemName.toLowerCase().indexOf($scope.searchList.foodName.toLowerCase()) != -1) &&
($scope.searchList.people <= 1 && $scope.searchList.budget == '' || item.cost*1 <= $scope.searchList.budget) && 
($scope.searchList.people <= 1 && $scope.searchList.budget == '' ||($scope.searchList.budget / $scope.searchList.people) >= item.cost*1 ) &&
(item.cuisine.toLowerCase().indexOf($scope.searchList.cuisine.toLowerCase()) != -1) &&
(item.subType.toLowerCase().indexOf($scope.searchList.foodType.toLowerCase()) != -1)) {
	 return true;
	}
    return false;
 };

}]);
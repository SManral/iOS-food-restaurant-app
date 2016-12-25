angular.module('myApp')
.controller('Menucontroller', ['$scope','$http','$state','$stateParams', function($scope, $http, $state, $stateParams){
    if(typeof localStorage["User-Data"] !== 'undefined') {debugger;
        if(typeof localStorage["User-Data"].type !== 'undefined' && localStorage["User-Data"].type !=="user") {
            $scope.user = {};
        } else {
            $scope.user = JSON.parse(localStorage["User-Data"])
        }  
    } else {
       $scope.user = {}; 
    }
	$scope.servingDurations = ["breakfast","Lunch","Brunch","Breakfast/Lunch","Dinner","Lunch/Dinner","Late-Night","All"];
    $scope.dishTypes = ["Main dish","Salads","Soups","Appetizers/Starters","Entrée","Pasta & Noodles","Pizzas","Desserts","Beverages","Kids Menu","Burger/Sandwiches","Seafood"];
    $scope.qtyUnits = ["plate","lb","kg","slice","pieces",""];
    $scope.cuisines = ["American","African","British","Caribbean","Chinese","French","Greek","Indian","Italian","Japenese","Mediterranean","Mexican","Moroccan","Spanish","Thai","Turkish","Vietamese"];
    debugger;
    $scope.menuItems = 
        [{
            restID: $scope.user._id,
        	itemName: '',
            subType: '',
            cuisine: '',
            description: '',
            duration: '',
            quantity: 1,
            qtyUnit: '',
            cost: 0

         }];

    $scope.addItem = function() {
        $scope.menuItems.push({
            restID: $scope.user._id,
        	itemName: '',
            subType: '',
            cuisine: '',
            description: '',
            duration: '',
            quantity:0,
            qtyUnit:'',
            cost: 0
        });
    },


    $scope.removeItem = function(index) {
        $scope.menuItems.splice(index, 1);
    },
    $scope.removeMenuItem = function(itemId) {
        var data = {
            itemId : itemId
        }
        angular.forEach($scope.menusRestInfos, function(menu, index){
            if(menu._id === itemId){
                debugger;
                $http.post('api/restaurant/removemenu', data)
                .success(function(callback){debugger;
                    if(callback.res == 'success') {
                        $scope.menusRestInfos = callback.data;
                        $scope.menuItems.splice(index, 1);
                    }
                })
            }
         })
    }


	$scope.save_submit = function() { debugger;
        $http.post('api/restaurant/addmenu', $scope.menuItems)
			.success(function(callback){
				if(callback.res == 'error') {
					$scope.callback = callback.data;
				}
				else if(callback.res == 'success') {
					$scope.callback = '';
				alert("Items added to the menu successfully");	
            $state.go('restaurant_formatted_menu', {idRest: callback.data.restID});
    
				}
				console.log(callback);
			}).error(function(err){
				$scope.callback = err.data;
				console.log(err);
			})
    },
    $scope.total = function() {
        var total = 0;
        angular.forEach($scope.menuItems, function(item) {
            total += item.qty * item.cost;
        })

        return total;
	}

    if(($state.current.name === 'restaurant_formatted_menu')&& typeof $stateParams.idRest !== "undefined"){
        var data = {
            _id : $stateParams.idRest
        } 
        $http.post('api/restaurant/get', data)
            .success(function(callback){
                if(callback.res == 'success') {
                    $scope.restuarantInfo = callback.data.restuarant;
                    $scope.menusRestInfos = callback.data.menus;
                }
                console.log(callback);
            }).error(function(err){
                $scope.callback = err.data;
                console.log(err);
            })
    }

}]);
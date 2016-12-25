angular.module('myApp', ['ui.router'])

.config(function ($stateProvider, $urlRouterProvider) {
    $stateProvider
        .state('login', {
            url: "/login",
            templateUrl: 'app/partials/login.html',
            controller: 'LoginController'
        })
        .state('signup', {
            url: "/signup",
            templateUrl: 'app/partials/signup.html',
            controller: 'SignupController'
        })
        .state('restaurant_signup', {
            url: "/restaurant_signup",
            templateUrl: 'app/partials/restaurant_signup.html',
            controller: 'SignupController'
        })
        .state('users_home', {
            url: "/users_home",
            templateUrl: 'app/partials/users_home.html',
            controller: 'UsersHomeController'
        })
        .state('restaurant_home', {
            url: "/restaurant_home",
            templateUrl: 'app/partials/restaurant_home.html',
            controller: 'Menucontroller'
        })
        .state('restaurant_formatted_menu', {
            url: "/restaurant_formatted_menu/:idRest",
            templateUrl: 'app/partials/restaurant_formatted_menu.html',
            controller: 'Menucontroller'
        })
    $urlRouterProvider.otherwise('/login');
});
 
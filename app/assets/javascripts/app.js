angular.module('estudy', ['ui.router', 'templates', 'Devise'])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
            $stateProvider
                .state('sign_in', {
                    url: '/sign_in',
                    templateUrl: 'auth/_login.html',
                    controller: 'AuthCtrl',
                    onEnter: ['$state', 'Auth', function($state, Auth) {
                        //Auth.currentUser().then(function (){
                        //    $state.go('profile');
                        //})
                    }]
                })
                .state('sign_up', {
                    url: '/sign_up',
                    templateUrl: 'auth/_registration.html',
                    controller: 'AuthCtrl',
                    onEnter: ['$state', 'Auth', function($state, Auth) {
                        //Auth.currentUser().then(function (){
                        //    $state.go('profile');
                        //})
                    }]
                })
                .state('profile', {
                    url: '/profile',
                    templateUrl: 'users/_user.html',
                    controller: 'UserCtrl',
                    resolve: {
                        user: ['$stateParams', 'Auth', function($stateParams, Auth) {
                            return Auth._currentUser
                        }]
                    }
                });
            $urlRouterProvider.otherwise('sign_in');
        }
    ]);
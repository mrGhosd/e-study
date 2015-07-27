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
                            //$state.go('home');
                        //})
                    }]
                })
                .state('sign_up', {
                    url: '/sign_up',
                    templateUrl: 'auth/_registration.html',
                    controller: 'AuthCtrl',
                    onEnter: ['$state', 'Auth', function($state, Auth) {
                        //Auth.currentUser().then(function (){
                            //$state.go('home');
                        //})
                    }]
                })
            $urlRouterProvider.otherwise('sign_in');
        }
    ]);
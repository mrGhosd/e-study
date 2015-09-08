angular.module('estudy', ['ui.router', 'templates', 'Devise', 'pascalprecht.translate'])
        .config([
            '$stateProvider',
            '$urlRouterProvider',
            '$translateProvider',
            function ($stateProvider, $urlRouterProvider, $translateProvider) {
                locale = I18n.currentLocale();
                $translateProvider.translations(locale, I18n.translations[locale]).preferredLanguage(locale);
                $stateProvider
                    .state('sign_in', {
                        url: '/sign_in',
                        templateUrl: 'auth/_login.html',
                        controller: 'AuthCtrl',
                        onEnter: ['$state', 'Auth', function ($state, Auth) {
                            //Auth.currentUser().then(function (){
                            //    $state.go('profile');
                            //})
                        }]
                    })
                    .state('sign_up', {
                        url: '/sign_up',
                        templateUrl: 'auth/_registration.html',
                        controller: 'AuthCtrl',
                        onEnter: ['$state', 'Auth', function ($state, Auth) {
                            //Auth.currentUser().then(function (){
                            //    $state.go('profile');
                            //})
                        }]
                    })
                    .state('profile', {
                        url: '/profile',
                        templateUrl: 'users/_user.html',
                        controller: 'UserCtrl',
                    });
                $urlRouterProvider.otherwise('sign_in');
            }
    ]);
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require angular
//= require angular-ui-router
//= require angular-rails-templates
//= require angular-devise
//= require angular-translate
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require_tree .

angular.module("estudy")
    .controller('AuthCtrl', [
        '$scope',
        '$state',
        'Auth',
        function($scope, $state, Auth){
            $scope.login = function() {;
                Auth.login($scope.user).then(function(){
                    $state.go('profile');
                }, function(error){
                    $scope.authForm.$errors = error;
                });
            };

            $scope.register = function() {
                Auth.register($scope.user).then(function(){
                    $state.go('profile');
                });
            };
        }
    ]);

angular.module('estudy')
    .controller('NavCtrl', [
        '$scope',
        '$state',
        //'$location',
        'Auth',
        function($scope, $state, Auth){
            $scope.signedIn = Auth.isAuthenticated;
            $scope.logout = Auth.logout;
            Auth.currentUser().then(function (user){
                $scope.user = user;
            });
            $scope.$on('devise:new-registration', function (e, user){
                $scope.user = user;
            });

            $scope.$on('devise:login', function (e, user){
                $scope.user = user;
            });

            $scope.$on('devise:logout', function (e, user){
                $scope.user = {};
            });
            $scope.isActive = function(route){
                return route === $state.current.url;
            }
        }]);
angular.module("estudy")
    .controller('UserCtrl', ['$scope', '$state', 'Auth', function($scope, $state){}]);
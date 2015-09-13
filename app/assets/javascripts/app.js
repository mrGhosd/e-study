angular.module('estudy', ['ui.router', 'templates', 'ui.bootstrap', 'Devise', 'pascalprecht.translate', 'ngFileUpload'])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        '$translateProvider',
        function($stateProvider, $urlRouterProvider, $translateProvider) {
            locale = I18n.currentLocale();
            $translateProvider.translations(locale, I18n.translations[locale]).preferredLanguage(locale);
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
                })
                .state('edit_profile', {
                    url: '/profile/edit',
                    templateUrl: 'users/_form.html',
                    controller: 'UserFormCtrl'
                })
            $urlRouterProvider.otherwise('sign_in');
        }
    ]);
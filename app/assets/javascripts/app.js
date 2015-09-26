angular.module('estudy',
    ['ui.router',
     'templates',
     'ui.bootstrap',
     'Devise',
     'pascalprecht.translate',
     'ngFileUpload',
     'ngSanitize',
     'textAngular',
     'StudentsRoutes'])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        '$translateProvider',
        function($stateProvider, $urlRouterProvider, $translateProvider) {
            locale = I18n.currentLocale();
            for(var lang in I18n.translations){
                $translateProvider.translations(lang, I18n.translations[lang]);
                if(lang === 'en') $translateProvider.preferredLanguage(lang)
            }
            $translateProvider.translations(locale, I18n.translations[locale]).preferredLanguage(locale);
            $stateProvider
                .state('sign_in', {
                    url: '/sign_in',
                    templateUrl: 'auth/_login.html',
                    controller: 'AuthCtrl',
                    onEnter: ['$state', 'Auth', function($state, Auth) {

                    }]
                })
                .state('sign_up', {
                    url: '/sign_up',
                    templateUrl: 'auth/_registration.html',
                    controller: 'AuthCtrl',
                    onEnter: ['$state', 'Auth', function($state, Auth) {

                    }]
                })
            $urlRouterProvider.otherwise('sign_in');
        }
    ]).run(['$location', function($location){
        console.log($location.$$absUrl.match("/users/password/edit"));
    }]);
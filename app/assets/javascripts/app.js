angular.module('estudy',
    ['ui.router',
     'templates',
     'ui.bootstrap',
     'Devise',
     'pascalprecht.translate',
     'ngFileUpload',
     'ngSanitize',
     'textAngular',
     'StudentsRoutes',
     'tmh.dynamicLocale'])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        '$translateProvider',
        'tmhDynamicLocaleProvider',
        function($stateProvider, $urlRouterProvider, $translateProvider, tmhDynamicLocaleProvider) {
            locale = I18n.currentLocale();
            console.log(I18n.translations);
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
    ]);
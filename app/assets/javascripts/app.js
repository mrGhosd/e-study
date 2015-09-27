angular.module('estudy',
    ['ui.router',
     'templates',
     'ui.bootstrap',
     'ngAnimate',
     'Devise',
     'pascalprecht.translate',
     'ngFileUpload',
     'ngSanitize',
     'textAngular',
     'StudentsRoutes',
     'ChatsRouter'])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        '$translateProvider',
        function($stateProvider, $urlRouterProvider, $translateProvider, $modal) {
            console.log($modal);
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
    ]).run(['$location', '$modal', function($location, $modal){
        function recoverPassword(){
            var modalInstance = $modal.open({
                animation: true,
                templateUrl: 'modal_windows/_recovery_password.html',
                controller: 'RecoverPasswordCtrl as modalView',
                size: 'lg'
            });
        }
        if($location.$$absUrl.match("/users/password/edit")) setTimeout(recoverPassword, 100);
    }]);
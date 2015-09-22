angular.module('StudentsRoutes',
    ['ui.router',
    'templates',
    'ui.bootstrap',
    'Devise',
    'pascalprecht.translate',
    'ngFileUpload']).config(function($stateProvider, $urlRouterProvider, $translateProvider){
    //define module-specific routes here
        $stateProvider
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

});

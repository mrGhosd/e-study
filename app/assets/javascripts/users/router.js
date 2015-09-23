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
            .state('users', {
                url: '/users',
                templateUrl: 'users/_users.html',
                controller: 'UsersCtrl',
                resolve: {
                    users: ['users', function(users){
                        return users.getAll();
                    }]
                }
            })

});

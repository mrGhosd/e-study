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
                resolve: {
                    user: ['Auth', '$location', function(Auth, $location){
                        return Auth.currentUser();
                    }],
                    profile: ['$state', function($state){
                        return true;
                    }]
                }
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
            .state('user', {
                url: '/users/{id}',
                templateUrl: 'users/_user.html',
                controller: 'UserCtrl',
                onEnter: ['$state', '$stateParams', '$location', 'Auth', function($state, $stateParams, $location, Auth) {
                    Auth.currentUser().then(function (user){
                        if(user.id == $stateParams.id) $location.path('/profile').replace("user", new User(user));
                    })
                }],
                resolve: {
                    user: ['users', '$stateParams', function(users, $stateParams){
                        return new User(users.get($stateParams.id));
                    }],
                    profile: ['$state', function($state){
                        return false;
                    }]
                }
            })

});

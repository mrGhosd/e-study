angular.module('ChatsRouter',
    ['ui.router',
        'templates',
        'ui.bootstrap',
        'Devise',
        'pascalprecht.translate',
        'ngFileUpload']).config(function($stateProvider, $urlRouterProvider, $translateProvider){
        //define module-specific routes here
        $stateProvider
            .state('chats', {
                url: '/chats',
                templateUrl: 'chats/_index.html',
                controller: 'ChatsCtrl',
                resolve: {
                    chats: ['chats', function(chats){
                        return chats.getAll();
                    }]
                }
            })
    });

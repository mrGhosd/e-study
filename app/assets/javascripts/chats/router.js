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
            .state('create_chat', {
                url: '/chats/new',
                templateUrl: 'chats/_form.html',
                controller: 'ChatsFormCtrl',
                resolve: {
                    chatOwner: ['Auth', function(Auth){
                        return Auth.currentUser();
                    }],
                    requestType: function(){ return "POST"; }
                }
            })
    });

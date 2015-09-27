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
            .state('chat', {
                url: '/chats/:id',
                templateUrl: 'chats/_chat.html',
                controller: 'ChatCtrl',
                resolve: {
                    chat: ['chats', '$stateParams', function(chats, $stateParams){
                        return chats.get($stateParams.id);
                    }],
                    currentUser: ['Auth', function(Auth){
                       return Auth.currentUser();
                    }]
                }
            })
    });

angular.module("estudy")
    .controller('ChatsFormCtrl',
    ['$scope',
        '$state',
        'Auth',
        'chats',
        'chatOwner',
        'requestType',
        function($scope, $state, Auth, chats, chatOwner, requestType){
            console.log(chatOwner);
            console.log(requestType);
        }]);
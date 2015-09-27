angular.module("estudy")
    .controller('ChatCtrl',
    ['$scope',
        '$state',
        'Auth',
        'chats',
        'chat',
        'currentUser',
        function($scope, $state, Auth, chats, chat, currentUser){
            $scope.currentUser = currentUser.user;
            $scope.chat = chat;
        }]);
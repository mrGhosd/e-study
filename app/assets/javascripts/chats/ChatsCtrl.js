angular.module("estudy")
    .controller('ChatsCtrl',
    ['$scope',
        '$state',
        'Auth',
        'chats',
        function($scope, $state, Auth, chats){
            console.log(chats);
            $scope.chats = chats;

        }]);
angular.module("estudy")
    .controller('ChatsCtrl',
    ['$scope',
        '$state',
        'Auth',
        'chats',
        function($scope, $state, Auth, chats){
            $scope.chats = chats.chats;

        }]);
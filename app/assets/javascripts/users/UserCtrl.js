angular.module("estudy")
    .controller('UserCtrl',
    ['$scope',
        '$state',
        'Auth',
        '$modal',
        'user',
        'profile',
        'users',
        function($scope, $state, Auth, $modal, user, profile, users){
            $scope.isProfile = profile;
            $scope.user = profile ? new User(user.user) : user;

            $scope.dynamicPopover = {
                content: 'Hello, World!',
                templateUrl: 'messagePopover.html',
                title: 'Написать сообщение'
            };

            $scope.createMessage = function(){
                var responder = $scope.user;
                var writer = Auth._currentUser.user;
                console.log($scope);
            }
        }]);
angular.module("estudy")
    .controller('UserCtrl',
    ['$scope',
        '$state',
        'Auth',
        '$modal',
        'user',
        'profile',
        'users',
        'messages',
        function($scope, $state, Auth, $modal, user, profile, users, messages){
            $scope.isProfile = profile;
            $scope.user = profile ? new User(user.user) : user;

            $scope.dynamicPopover = {
                content: 'Hello, World!',
                templateUrl: 'messagePopover.html',
                title: 'Написать сообщение'
            };

            $scope.createMessage = function(){
                var params = {message: {
                    user_id: Auth._currentUser.user.id,
                    responder_id: $scope.user.id,
                    text: $scope.message
                }};
                messages.create(params).success(function(data){
                    console.log(data);
                });
                console.log($scope);
            }
        }]);
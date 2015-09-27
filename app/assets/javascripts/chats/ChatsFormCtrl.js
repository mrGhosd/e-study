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

            $scope.submitForm = function(){
                var chatParams = {chat: {
                   name: $scope.name,
                    owner_id: chatOwner.user.id
                }};
                chats.create(chatParams).success(function(data){
                   $state.go('chats');
                }).error(function(data){
                    console.log(data);
                });
            }
        }]);
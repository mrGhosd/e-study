angular.module("estudy")
    .controller('UsersCtrl',
        ['$scope',
        '$state',
        'Auth',
        'users',
        function($scope, $state, Auth, users){
            $scope.users = users.users;

            $scope.search = function(){
                users.search($scope.searchField).then(function(data){
                    $scope.users = data;
                });
            }
        }]);
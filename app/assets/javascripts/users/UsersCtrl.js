angular.module("estudy")
    .controller('UsersCtrl',
        ['$scope',
        '$state',
        'Auth',
        'users',
        function($scope, $state, Auth, users){
            $scope.users = users.data;
        }]);
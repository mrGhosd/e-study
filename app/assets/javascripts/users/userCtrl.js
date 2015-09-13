angular.module("estudy")
    .controller('UserCtrl', ['$scope', '$state', 'Auth', function($scope, $state, Auth){
        console.log(Auth._currentUser);
    }]);
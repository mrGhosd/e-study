angular.module("estudy")
    .controller('UserCtrl',
    ['$scope',
        '$state',
        'Auth',
        '$modal',
        'user',
        'profile',
        function($scope, $state, Auth, $modal, user, profile){
            $scope.isProfile = profile;
            $scope.user = profile ? new User(user.user) : user;
        }]);
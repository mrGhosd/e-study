angular.module("estudy")
    .controller('UserCtrl',
    ['$scope',
        '$state',
        'Auth',
        '$modal',
        'user',
        'profile',
        function($scope, $state, Auth, $modal, user, profile){
            $scope.user = user;
            $scope.isProfile = profile;
        }]);
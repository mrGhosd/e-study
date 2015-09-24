angular.module("estudy")
    .controller('UserCtrl',
    ['$scope',
        '$state',
        'Auth',
        '$modal',
        'user',
        'profile',
        'Lightbox',
        function($scope, $state, Auth, $modal, user, profile, Lightbox){
            $scope.user = user;
            $scope.isProfile = profile;

        }]);
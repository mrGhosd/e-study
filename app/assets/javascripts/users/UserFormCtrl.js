angular.module('estudy')
    .controller('UserFormCtrl', [
        '$scope',
        '$state',
        'Auth',
        'Upload',
        function($scope, $state, Auth, Upload){
            $scope.upload = function (file) {
                Upload.upload({
                    url: 'images',
                    fields: {'imageable_type': "User"},
                    file: file
                }).success(function (data, status, headers, config) {
                    $scope.user.image = data;
                })
            };
        }]);
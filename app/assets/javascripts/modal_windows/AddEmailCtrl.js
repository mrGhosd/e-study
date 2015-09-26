angular.module("estudy")
    .controller('AddEmailCtrl', [
        '$scope',
        '$state',
        '$modal',
        '$modalInstance',
        'Auth',
        'url',
        function($scope, $state, $modal, $modalInstance, Auth, url) {
            $scope.enterMail = function(){
                window.location.href = url + "?email=" + $scope.emailCtrl.emailForm.additionalEmail;
                console.log($scope.emailCtrl.emailForm.additionalEmail);
            }
        }
    ]);
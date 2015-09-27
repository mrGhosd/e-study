angular.module("estudy")
    .controller('RecoverPasswordCtrl', [
        '$scope',
        '$state',
        '$modal',
        '$modalInstance',
        'Auth',
        '$location',
        'users',
        function($scope, $state, $modal, $modalInstance, Auth, $location, users) {
            $scope.changePassword = function(){
                console.log($scope.modalView.RecoverForm);
                console.log(users);
                var token = $location.$$absUrl.split("=")[1].split("#")[0];
                var params = {user: {
                    password: $scope.modalView.RecoverForm.password,
                    password_confirmation: $scope.modalView.RecoverForm.password_confirmation,
                    reset_password_token: token
                }};
                users.changePassword(params).success(function(data){
                    $modalInstance.dismiss('cancel');
                    $location.path("#/sign_in");
                }).error(function(errors){
                    $scope.modalView.RecoverForm.$submitted = true;
                    $scope.modalView.RecoverForm.$errors = errors;
                    $scope.modalView.RecoverForm.$invalid = true;
                    $scope.modalView.RecoverForm.$valid = false;
                });
            }
        }
    ]);
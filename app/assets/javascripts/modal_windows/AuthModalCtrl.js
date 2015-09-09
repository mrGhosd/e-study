angular.module("estudy")
    .controller('AuthModalCtrl', [
        '$scope',
        '$state',
        '$modal',
        '$modalInstance',
        'Auth',
        function($scope, $state, $modal, $modalInstance, Auth){
            $scope.login = function() {
                Auth.login($scope.user).then(function(){
                    $state.go('profile');
                }, function(error){
                    $scope.authForm.$errors = error;
                });
            };

            $scope.register = function() {
                Auth.register($scope.user).then(function(){
                    $state.go('profile');
                });
            };

            $scope.ok = function(){
                console.log($scope.modalView.authForm);
            };
            $scope.cancel = function(){
                $modalInstance.dismiss('cancel');
            };

            $scope.setModalTitle = function(title){
                $scope.modalTitle = title;
            };

        }
    ]);
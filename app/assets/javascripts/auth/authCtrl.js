angular.module("estudy")
    .controller('AuthCtrl', [
        '$scope',
        '$state',
        'Auth',
        function($scope, $state, Auth){
            $scope.login = function() {
                console.log($scope.user);
                Auth.login($scope.user).then(function(){
                    $state.go('profile');
                });
            };

            $scope.register = function() {
                Auth.register($scope.user).then(function(){
                    $state.go('profile');
                });
            };
        }
    ]);
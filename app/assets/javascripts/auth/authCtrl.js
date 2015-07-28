angular.module("estudy")
    .controller('AuthCtrl', [
        '$scope',
        '$state',
        'Auth',
        '$translate',
        function($scope, $state, Auth, $translate){
            $scope.login = function() {;
                Auth.login($scope.user).then(function(){
                    $state.go('profile');
                }, function(error){
                    $scope.errors = error;
                });
            };

            $scope.register = function() {
                Auth.register($scope.user).then(function(){
                    $state.go('profile');
                });
            };
        }
    ]);
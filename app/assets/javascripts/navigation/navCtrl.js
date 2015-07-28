angular.module('estudy')
    .controller('NavCtrl', [
        '$scope',
        '$location',
        'Auth',
        function($scope, $location, Auth){
            $scope.signedIn = Auth.isAuthenticated;
            $scope.logout = Auth.logout;
            Auth.currentUser().then(function (user){
                $scope.user = user;
            });
            $scope.$on('devise:new-registration', function (e, user){
                $scope.user = user;
            });

            $scope.$on('devise:login', function (e, user){
                $scope.user = user;
            });

            $scope.$on('devise:logout', function (e, user){
                $scope.user = {};
            });
            $scope.isActive = function(route){
                return route === $location.path();
            }
        }]);
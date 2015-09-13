angular.module('estudy')
    .controller('HeaderCtrl', [
        '$scope',
        '$modal',
        '$state',
        //'$location',
        'Auth',
        function($scope, $modal, $state, Auth){
            $scope.signedIn = Auth.isAuthenticated;
            $scope.logout = Auth.logout;
            $scope.signIn = function(){
                var modalInstance = $modal.open({
                    animation: true,
                    templateUrl: 'modal_windows/_auth_window.html',
                    controller: 'AuthModalCtrl as modalView',
                    size: 'lg',
                    resolve: {
                        currentTab: function () {
                            return "auth";
                        }
                    }

                });
                modalInstance.opened.then(function($scope, arg){
                    console.log(modalInstance.$scope);
                });
            };
            $scope.signUp = function(){
                var modalInstance = $modal.open({
                    animation: true,
                    templateUrl: 'modal_windows/_auth_window.html',
                    controller: 'AuthModalCtrl as modalView',
                    size: 'lg',
                    resolve: {
                        currentTab: function () {
                            return "reg";
                        }
                    }
                });
            };
            $scope.$on('devise:logout', function (e, user){
                $scope.user = {};
            });
        }]);
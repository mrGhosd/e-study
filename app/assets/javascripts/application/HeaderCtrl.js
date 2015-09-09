angular.module('estudy')
    .controller('HeaderCtrl', [
        '$scope',
        '$modal',
        '$state',
        //'$location',
        'Auth',
        function($scope, $modal, $state, Auth){
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
                    console.log($scope);
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
            }
        }]);
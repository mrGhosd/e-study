angular.module('estudy')
    .controller('HeaderCtrl', [
        '$scope',
        '$modal',
        '$state',
        //'$location',
        'Auth',
        function($scope, $modal, $state, Auth){
            console.log($modal);
            $scope.signIn = function(){
                var modalInstance = $modal.open({
                    animation: true,
                    templateUrl: 'modal_windows/_auth_window.html',
                    controller: 'AuthModalCtrl as modalView',
                    size: 'lg',
                    resolve: {
                        items: function () {
                            return $scope.items;
                        }
                    }
                })

            }
        }]);
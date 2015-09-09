angular.module("estudy")
    .controller('AuthModalCtrl', [
        '$scope',
        '$state',
        '$modal',
        '$modalInstance',
        'Auth',
        'currentTab',
        function($scope, $state, $modal, $modalInstance, Auth, currentTab){
            $scope.modalView = {};
            if(currentTab === 'reg'){
                $scope.activeTabReg = true;
            } else if(currentTab == 'auth'){
                $scope.activeTabAuth = true;
            }
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

            $scope.setCurrentViewDetails = function(title, form){
                $scope.modalTitle = title;
                $scope.modalView.currentForm = form;
            };

            $scope.init = function(){
                console.log($scope.modalView);
            };
            $scope.defineCurrentForm = function(){
                var object = $scope.modalView;
                if(object.hasOwnProperty("currentForm")){
                    var form;
                    if($scope.activeTabAuth){
                        form = $scope.modalView.authForm;
                    } else if($scope.activeTabReg){
                        form = $scope.modalView.regForm;
                    }
                    $scope.modalView.currentForm = form;
                }
            }
            $scope.$on('$viewContentLoaded', function(){
                console.log("1");
            });
        }
    ]);
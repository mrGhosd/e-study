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

            $scope.login = function(){
                var userParams = {
                    email: $scope.modalView.authForm.email,
                    password: $scope.modalView.authForm.password
                };

                Auth.login(userParams).then(function(){
                    $modalInstance.dismiss('cancel');
                }, function(error){
                    $scope.modalView.authForm.$submitted = true;
                    $scope.modalView.authForm.$errors = error.data.error;
                    $scope.modalView.authForm.$invalid = true;
                    $scope.modalView.authForm.$valid = false;
                    console.log($scope.modalView.authForm);
                });
            };

            $scope.ok = function(){

                $scope.modalView.currentForm.$submitted = true;
                if(userParams.password_confirmation){
                    Auth.register(userParams).then(function(){
                        $modalInstance.dismiss('cancel');
                    }, function(error){

                    });
                } else {

                }
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
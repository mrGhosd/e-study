angular.module("estudy")
    .controller('UsersCtrl',
        ['$scope',
        '$state',
        'Auth',
        'users',
        function($scope, $state, Auth, users){
            $scope.users = users.users;


            $scope.createMessage = function(){

            };

            $scope.search = function(){
              searchRequest($scope.searchField);
            };

            $scope.dynamicSearch = function(){
                if($scope.searchField !== ""){
                    searchRequest($scope.searchField);
                } else {
                    users.getAll().then(function(data){
                        $scope.users = data;
                    });
                }
            };

            function searchRequest(request){
                users.search(request).then(function(data){
                    $scope.users = data;
                });
            }
        }]);
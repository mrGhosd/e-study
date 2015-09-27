angular.module('estudy')
    .controller('UserFormCtrl', [
        '$scope',
        '$state',
        'users',
        'Auth',
        '$filter',
        'Upload',
        function($scope, $state, users, Auth, $filter, Upload){
            Auth.currentUser().then(function(user){
                $scope.user = user.user;
                if($scope.user.hasOwnProperty("date_of_birth")){
                    $scope.user.date_of_birth = new Date($filter("date")(Date.now(), 'yyyy-MM-dd'));
                }
            });

            $scope.update = function(){
                var user = $scope.user;
                var userParams = { user: {
                    surname: user.surname,
                    name: user.name,
                    email: user.email,
                    secondname: user.secondname,
                    date_of_birth: user.date_of_birth,
                    image: {
                        imageable_type: "User",
                        id: user.image.id
                    },
                    description: user.description
                }};
                users.update(user.id, userParams).success(function(data){
                    $state.go('user', {id: data.user.id});
                }).error(function(errors){
                    $scope.userForm.$submitted = true;
                    $scope.userForm.$errors = errors;
                    $scope.userForm.$invalid = true;
                });

            };
            $scope.upload = function (file) {
                Upload.upload({
                    url: 'images',
                    fields: {'imageable_type': "User"},
                    file: file
                }).success(function (data, status, headers, config) {
                    $scope.user.image = data;
                    console.log($scope.user);
                })
            };
        }]);
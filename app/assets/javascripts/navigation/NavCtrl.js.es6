//angular.module('estudy')
//    .controller('NavCtrl', [
//        '$scope',
//        '$state',
//        //'$location',
//        'Auth',
//        function($scope, $state, Auth){
//            $scope.signedIn = Auth.isAuthenticated;
//            $scope.logout = Auth.logout;
//            Auth.currentUser().then(function (user){
//                $scope.user = user;
//            });
//            $scope.$on('devise:new-registration', function (e, user){
//                $scope.user = user;
//            });
//
//            $scope.$on('devise:login', function (e, user){
//                $scope.user = user;
//            });
//
//            $scope.$on('devise:logout', function (e, user){
//                $scope.user = {};
//            });
//            $scope.isActive = function(route){
//                return !!$state.current.url.match(route);
//            }
//        }]);
'use strict';

class NavCtrl {
    constructor($scope, $state, Auth) {
        this.$scope = $scope;
        this.$state = $state;
        this.Auth = Auth;

        this.$scope.signedIn = Auth.isAuthenticated;
        this.$scope.logout = Auth.logout;

        this.Auth.currentUser().then(function (user){
            this.$scope.user = user;
        });
        this.$scope.$on('devise:new-registration', function (e, user){
            this.$scope.user = user;
        });

        this.$scope.$on('devise:login', function (e, user){
            console.log(this.$scope);
            this.$scope.user = user;
        });

        this.$scope.$on('devise:logout', function (e, user){
            this.$scope.user = {};
        });
    }

    isActive(route){
        return !!this.$state.current.url.match(route);
    }
}
angular.module('estudy').controller('NavCtrl', NavCtrl);

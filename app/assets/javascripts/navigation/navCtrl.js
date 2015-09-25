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
    }
}
export default NavCtrl;
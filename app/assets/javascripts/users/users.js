angular.module('estudy').factory('users', [ '$http', function($http){
    // service body
    var object = {
        users: []
    };
    object.getAll = function() {
        return $http.get('/users.json').success(function(data){
            angular.copy(data, object.users);
        });
    };
    object.create = function(user) {
        return $http.post('/users.json', user).success(function(data){
            object.users.push(data);
        });
    };
    object.get = function(id){
        return $http.get('/users/' + id + '.json').then(function(res){
            return res.data;
        });
    };
    object.update = function(id, user){
        return $http.put('/users/' + id + '.json', user).success(function(res){
            return res.data;
        });
    };

    return object;
}]);
angular.module('estudy').factory('users', [ '$http', '$q', function($http, $q){
    // service body
    var object = {
        users: [],
        searchResults: []
    };
    object.getAll = function() {
        var def = $q.defer();
        $http.get('/users.json').success(function(data){
            var newUsers = [];
            for(var i = 0; i < data.users.length; i++){
                var user = new User(data.users[i]);
                newUsers.push(user);
            }
            def.resolve(newUsers);
            angular.copy(newUsers, object.users)
        });
        return def.promise;
    };
    object.create = function(user) {
        return $http.post('/users.json', user).success(function(data){
            angular.copy(data, object.users);
        });
    };
    object.get = function(id){
        var def = $q.defer();
        $http.get('/users/' + id + '.json').then(function(res){
            def.resolve(new User(res.data.user));
        });
        return def.promise;
    };
    object.update = function(id, user){
        return $http.put('/users/' + id + '.json', user).success(function(res){
           return res.data;
        });
    };

    object.search = function(query){
        var def = $q.defer();
        params = {object: "user", query: query};
        $http.get('/search.json', {params: params}).success(function(data){
            var newUsers = [];
            for(var i = 0; i < data.length; i++){
                var user = new User(data[i]);
                newUsers.push(user);
            }
            def.resolve(newUsers);
        });
        return def.promise;
    };

    object.resetPassword = function(email){
        var def = $q.defer();
        var params = {email: email};
        $http.post('/users/generate_new_password_email.json', params).success(function(data){
            def.resolve(data);
        });
        return def.promise;
    };

    object.changePassword = function(params){
        return $http.post('/users/reset_password.json', params).success(function(res){
           return res.data;
        });
    };

    return object;
}]);
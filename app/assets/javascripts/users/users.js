angular.module('estudy').factory('users', [ '$http', '$q', function($http, $q){
    // service body
    var def = $q.defer();
    var object = {
        users: []
    };
    object.getAll = function() {
        $http.get('/users.json').success(function(data){
            var newUsers = [];
            for(var i = 0; i < data.length; i++){
                var user = new User(data[i]);
                newUsers.push(user);
            }
            def.resolve(newUsers);
            angular.copy(data, object.users)
        });
        return def.promise;
    };
    object.create = function(user) {
        return $http.post('/users.json', user).success(function(data){
            angular.copy(data, object.users);
        });
    };
    object.get = function(id){
        return $http.get('/users/' + id + '.json').then(function(res){
            return new User(res.data);
        });
    };
    object.update = function(id, user){
        $http.put('/users/' + id + '.json', user).success(function(res){
            def.resolve(res.data);
        });
        return def.promise;
    };

    object.correctNaming = function(user){
        console.log(user);
        if(user.surname && user.name){
            if(user.secondname ){
                return user.surname + " " + user.name + " " + user.secondname;
            } else {
                return user.surname + " " + user.name;
            }
        } else {
            return user.email;
        }
    }

    return object;
}]);
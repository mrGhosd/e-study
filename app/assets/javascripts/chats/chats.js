angular.module('estudy').factory('chats', [ '$http', '$q', function($http, $q){
    // service body
    var object = {
        chats: [],
        searchResults: []
    };
    object.getAll = function() {
        var def = $q.defer();
        $http.get('/chats.json').success(function(data){
            var newChats = [];
            for(var i = 0; i < data.chats.length; i++){
                var chat = new User(data.chats[i]);
                newChats.push(chat);
            }
            def.resolve(newChats);
            angular.copy(newChats, object.users)
        });
        return def.promise;
    };

    return object;
}]);
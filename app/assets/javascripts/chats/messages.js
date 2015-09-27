angular.module('estudy').factory('messages', [ '$http', '$q', function($http, $q){
    // service body
    var object = {
        messages: [],
        searchResults: []
    };
    object.getAll = function() {
        var def = $q.defer();
        $http.get('/chats.json').success(function(data){
            var newChats = [];
            for(var i = 0; i < data.chats.length; i++){
                var chat = new Chat(data.chats[i]);
                newChats.push(chat);
            }
            def.resolve(newChats);
            angular.copy(newChats, object.users)
        });
        return def.promise;
    };
    object.create = function(params){
        return $http.post('/messages.json', params).success(function(data){
            object.chats.push(data.chat);
        });
    };
    return object;
}]);
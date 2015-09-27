var Chat = function(attributes){
    for(var key in attributes){
        this[key] = attributes[key];
        if(key === "messages"){
            var msg = [];
            for(var i = 0; i < attributes.messages.length; i++){
                var message = new Message(attributes.messages[i]);
                msg.push(message);
            }
            this[key] = msg;
        }
    }

    return this;
};
var Chat = function(attributes){
    for(var key in attributes){
        this[key] = attributes[key];
    }

    return this;
};
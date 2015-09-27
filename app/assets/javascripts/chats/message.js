var Message = function(attributes){
    for(var key in attributes){
        this[key] = attributes[key];
        if(key === "user"){
            this[key] = new User(attributes[key]);
        }
    }

    return this;
};
var User = function(attributes){
    for(var key in attributes){
        this[key] = attributes[key];
    }

    this.correctNaming = function(){
        if(this.surname && this.name){
            return this.surname + " " + this.name;
        } else {
            return this.email;
        }
    };
    return this;
};
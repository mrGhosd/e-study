var User = function(attributes){
    for(var key in attributes){
        this[key] = attributes[key];
    }

    this.correctNaming = function(){
        if(this.surname && this.name){
            if(this.secondname){
                return this.surname + " " + this.name + " " + this.secondname;
            }
            return this.surname + " " + this.name;
        } else {
            return this.email;
        }
    };

    this.humanizedDate = function(date){
        var newDate = new Date(date);
        var time = [newDate.getHours(), newDate.getMinutes(), newDate.getSeconds()];
        var date = [newDate.getDate(), newDate.getMonth() + 1, newDate.getFullYear()];
        return time.join(":") + " " + date.join(".");
    };
    this.humanizedOnlyDate = function(date){
        var newDate = new Date(date);
        var date = [newDate.getDate(), newDate.getMonth() + 1, newDate.getFullYear()];
        return date.join(".");
    }
    return this;
};
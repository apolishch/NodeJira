var request=require("request");

module.exports = function(host, user, password){
  self=this;
  this.cookies;
  this.user=user;
  this.host=host;
  this.password=password;

  function jiraOptions(){
    return ({
      json: true,
      jar: false
    });
  }
  
  function jiraRequest(method, url, body, callback){
    var options = jiraOptions();
    options.method = method;
    options.url = self.host+url;
    options.headers = getCookie();
    if((body)&&(method=="PUT" || method=="POST")){
      options.body=body;
    };
    request(options, function(err, response, body){
      console.log(options);
      console.log(response.statusCode);
      if(callback){
        if(err){
          callback(err, null);
        } else if ([200,201,202,203,204].indexOf(response.statusCode)==-1){
          callback({"code": response.statusCode}, {"msg": body}, null);
        } else {
          callback(null, body);
        }  
      }
    });
  }
  
  function getCookie(){
    var options = jiraOptions();
    options.url = self.host+'/rest/auth/latest/session'
    if (self.cookies) {
      options.method = "GET"
      delete options["body"];
      options.headers = self.cookies;
    } else {
      options.method = "POST";
      delete options["headers"];
      options.body = {"username": self.user, "password": self.password};
    }
    request(options, function(err, response, body){
      if([400,401,402,403,404].indexOf(response.statusCode)!=-1){
        self.cookies = null;
        return getCookie();
      } else if(response.headers['set-cookie']){
        return self.cookies={"Cookie": response.headers['set-cookie'].join(';')};
      }
    });
    
  }
  
  return {
    get: function(url, callback){
      jiraRequest("GET", url, null, callback);
    },
    put: function(url, body, callback){
      jiraRequest("PUT", url, body, callback);
    },
    post: function(url, body, callback){
      jiraRequest("POST", url, body, callback);
    },
    delete: function(url, callback){
      jiraRequest("DELETE", url, null, callback);
    }
  }
};
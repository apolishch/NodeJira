var jira_request = require('./jira_request');

module.exports = function(host, user, password) {
  request = new jira_request(host, user, password);
  return {
    get_issues: function(jql, callback) {
      request.get("/rest/api/latest/search?jql="+jql, callback);
    },
    get_issue: function(id, callback) {
      request.get("/rest/api/latest/issue/"+id, callback);
    }
  }
};
var should      = require('should'),
    helper      = require("../jira_helpers")(process.env.JIRA_HOSTNAME, process.env.JIRA_USERNAME, process.env.JIRA_PASSWORD);

describe('Api test', function() {
  it('should get record', function(done){
    helper.get_issue('OEP-1234', function(err, response) {
      should.not.exist(err);
      should.exist(response);
      done();
    });
  });

  it("should get back a list of issues", function(done){
    helper.get_issues("project='test'", function(err, response) {
      should.not.exist(err);
      should.exist(response);
      done();
    });
  });
});
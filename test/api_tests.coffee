jira_api = require '../jira_api'
username = process.env.USERNAME
password = process.env.PASSWORD
jirahost = process.env.JIRAHOST
jiraptcl = process.env.JIRAPTCL
assert = require 'assert'


describe 'api test', ->
  describe 'Api test login fail username', ->
    it 'should fail to login', (done) ->
      jira_api.login 'fail', password, jirahost, jiraptcl, (err, body)->
        assert.equal err.code, 401
        done()

    it 'should fail to return issue', (done) ->
      jira_api.get_issue_details 'OEP-1234', (err, response, body)->
        done(TypeError)

  describe 'Api test login fail password', ->
    it 'should fail to login', (done) ->
      jira_api.login username, 'fail', jirahost, jiraptcl, (err, body)->
        assert.equal err.code, 401
        done()

  describe 'Api test login fail jirahost', ->
    it 'should fail to login', (done) ->
      jira_api.login username, password, 'fail', jiraptcl, (err, body)->
        assert.equal err.code, 'ENOTFOUND'
        done()

  describe 'Api test login pass', ->
    it 'should login successfully', (done) ->
       jira_api.login username, password, jirahost, jiraptcl, (done)
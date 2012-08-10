jira_api_file = require '../jira_api'
username = process.env.USERNAME
password = process.env.PASSWORD
jirahost = process.env.JIRAHOST
jiraptcl = process.env.JIRAPTCL
assert = require 'assert'

jira_api = new jira_api_file.JiraApiConnector(username,password,jirahost,jiraptcl)

describe 'api test', ->

  describe 'Api test login pass', ->
    it 'should login successfully', (done) ->
       jira_api.login (done)

    it 'should return issue', (done) ->
      jira_api.get_issue_details 'OEP-1234', (err, response, body)->
        assert.equal response.key, "OEP-1234"
        done()
    
    it 'should logout', (done)->
      jira_api.logout (err, response, body) ->
        assert.equal jira_api.cookies, null
        done()     
jira_api = require '../jira_api'
username = process.env.USERNAME
password = process.env.PASSWORD

describe 'api test', ->
  describe 'Login test', ->
    it 'should login successfully', (done) ->
       jira_api.login username, password, "jira.eloquacorp.com", "https", (err, body)->
         done
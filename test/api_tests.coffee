jira_api = require '../jira_api'
username = process.env.USERNAME
password = process.env.PASSWORD
jirahost = process.env.JIRAHOST
jiraptcl = process.env.JIRAPTCL



describe 'api test', ->
  describe 'Login test', ->
    it 'should login successfully', (done) ->
       jira_api.login username, password, jirahost, jiraptcl, (done)
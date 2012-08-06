jira_api = require '../jira_api'
username = process.env.USERNAME
password = process.env.PASSWORD
jirahost = process.env.JIRAHOST
jiraptcl = process.env.JIRAPTCL



describe 'api test', ->
  describe 'Api test login fail username', ->

  describe 'Api test login fail password', ->

  describe 'Api test login fail jirahost', ->

  describe 'Api test login fail jiraptcl', ->


  describe 'Api test login pass', ->
    it 'should login successfully', (done) ->
       jira_api.login username, password, jirahost, jiraptcl, (done)
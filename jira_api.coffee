express = require 'express'
assets = require 'connect-assets'
request = require 'request'

app = express.createServer()

app.use express.favicon()
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session secret: 'randomstuffherethatstryingtobeasecret12@@124'
app.use app.router
app.use express.static "#{__dirname}/public"

port = process.env.PORT or 3000
app.listen port, -> console.log "Listening @ http://0.0.0.0:#{port}"
app.helpers
  title: "NodeJira"

class JiraApiConnector
  constructor: (@username, @password, @host, @protocol)->
    @content_url= @protocol+"://"+@host+"/rest/api/latest"
    @authentication_url= @protocol+"://"+@host+"/rest/auth/latest/session"
    @cookies

  login: (cb)->
    request_options =
      url: this.authentication_url
      method: 'POST'
      body:
        username: @username
        password: @password
      json: true
      jar: false
    request request_options, (err, response, body)=>
      if cb?
        if err?
          cb err, null
        else if response?.statusCode not in [200, 201]
          cb code: response.statusCode, msg: body, null
        else
          cb null, body
          @cookies
          if response.headers['set-cookie']
            @cookies = response.headers['set-cookie']

  get_issue_details: (key, cb)->
    request_options =
      url: @content_url+"/issue/"+key
      method: 'GET'
      headers:
        Cookie: @cookies.join ";"
      json: true
      jar: false
    request request_options, (err, response, body)=>
      if cb?
        if err?
          cb err, null
        else if response?.statusCode not in [200,201]
          cb code: response.statusCode, msg: body, null
        else
          cb response, body

  get_issue_list: (jql, cb)->
    request_options =
      url: @content_url+"/search?jql="+jql
      method: 'GET'
      headers:
        Cookie: @cookies.join ";"
      json: true
      jar: false
    request request_options, (err, response, body)=>
      if cb?
        if err?
          cb err, null
        else if response?.statusCode not in [200,201]
          cb code: response.statusCode, msg: body, null
        else
          cb response, body

  logout: (cb)->
    request_options =
      url: @authentication_url
      method: 'DELETE'
      headers:
        Cookie: @cookies.join ";"
      json: true
      jar: false
    request request_options, (err, response, body)=>
      if cb?
        if err?
          cb err, null 
        else if response?.statusCode not in[204]
          cb code: response.statusCode, msg: body, null
        else
          @cookies = null
          cb null, body

exports.JiraApiConnector = JiraApiConnector
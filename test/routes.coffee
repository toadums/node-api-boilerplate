_ = require 'underscore'

global.logger = require '../utils/logger'
request = require 'request'
assert = require 'assert'
jar = request.jar()

login = (cb) ->
  request.post
    url: 'http://localhost:3333/api/login'
    form: {username: 'diddy', password: 'banana'}
    jar: jar
  , (err, res, body) ->
    if err then throw err
    body = JSON.parse(body)
    if body.user then cb()

isValidUser = (user) ->
  user._id? and user.username?

describe "User", ->
  describe 'POST /login', ->
    it 'Should login with a good username & pass', (done)->
      request.post
        url: 'http://localhost:3333/api/login'
        form: {username: 'diddy', password: 'banana'}
      , (err, res, body) ->
        if err then throw err
        body = JSON.parse(body)
        if body.user then done()
        else
          done "Bad response object"

    it 'Should fail with a bad username', (done)->
      request.post
        url: 'http://localhost:3333/api/login'
        form: {username: 'asdasd123123', password: 'banana'}
      , (err, res, body) ->
        if err then throw err
        if body is "Unauthorized" then done()
        else
          done body

    it 'Should fail with a bad password', (done)->
      request.post
        url: 'http://localhost:3333/api/login'
        form: {username: 'diddy', password: 'badpassklansd jaskld ahksjdas d jkashdk lahsd'}
      , (err, res, body) ->
        if err then throw err
        if body is "Unauthorized" then done()
        else
          done body

    it "Should return a list of users", (done) ->
      login ->
        request.get
          url: "http://localhost:3333/api/u"
          jar: jar
        , (err, res, body) ->
          body = JSON.parse body
          if (_.find body, (b) -> not isValidUser(b))
            done "Invalid results"
          else
            logger.info "Users:", body
            done()

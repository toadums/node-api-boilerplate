passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
User = require './models/user'

module.exports = (app) ->
  app.use passport.initialize()
  app.use passport.session()


  passport.use new LocalStrategy (username, password, done) ->
    User.findOne { username: username }, (err, user) ->
      if err then return done err
      if not user
        return done null, false, { message: 'Username does not exist.' }

      user.comparePassword password, (err, isMatch) ->
        if err then return done err
        if isMatch then return done null, user
        else return done null, false, { message: 'Incorrect password.' }

  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    User.findById id, (err, user) ->
      done err, user

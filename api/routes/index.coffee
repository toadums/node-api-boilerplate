passport = require 'passport'
Router = require './router'
express = require 'express'

# Possible actions for resources: index, create, show, destroy, update
# Usage: Router.resource <path>, {controller: <name>, only: <[action]>}

module.exports = () ->
  router = express.Router()
  Router.router = router

  Router.resource 'u', controller: 'users', only: [index, create, show, update, destroy]

  # ###############################
  # ########### Session ###########
  # ###############################
  Router.post 'login', controller: 'sessions', action: create
  Router.get 'logout', controller: 'sessions', action: destroy

  return router







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
  router.route '/login'
    .post passport.authenticate('local'), (req, res) ->
      res.json req.user

  router.route '/logout'
    .get require('../controllers/sessions').delete

  return router







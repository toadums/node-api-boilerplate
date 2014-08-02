passport = require 'passport'

module.exports = (router) ->

  ###############################
  ############ Users ############
  ###############################

  router.route '/u'
    .post require('../controllers/user').create
    .get require('../controllers/user').show

  router.route '/u/:user_id'
    .get require('../controllers/user').find
    .put require('../controllers/user').update
    .delete require('../controllers/user').delete

  ###############################
  ########### Session ###########
  ###############################

  router.route '/login'
    .post passport.authenticate('local'), require('../controllers/session').create

  router.route '/logout'
    .get require('../controllers/session').delete

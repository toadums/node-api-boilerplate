# Not sure how I want to handle things like rails :before_filter, I think this is the place though..
passport = require 'passport'

module.exports = class Controller
  isLoggedIn: (req, res, next) ->
    if req.user then next()
    else res.json
      err: "You must be logged in"

  authenticate: passport.authenticate('local')
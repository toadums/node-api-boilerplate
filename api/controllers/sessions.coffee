Controller = require './base_controller'

class SessionController extends Controller

  constructor: ->
    @beforeFilters = [
      {method: @authenticate, only: [create]}
    ]

  # POST /login
  create: (req, res) ->
    console.log "Login attempt"
    res.json
      success: true
      user: req.user

  # GET /logout
  destroy: (req, res) ->
    req.logout()
    res.json
      success: true

module.exports = new SessionController()
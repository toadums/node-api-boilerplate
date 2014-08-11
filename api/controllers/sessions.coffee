Controller = require './base_controller'

class SessionController extends Controller

  constructor: ->
    @beforeFilters = [
      {method: @authenticate, only: [create]}
    ]

  # POST /login
  create: (req, res) ->
    if req.user
      res.json
        user: req.user
    else res.json
      error: "Could not find user"

  # GET /logout
  destroy: (req, res) ->
    req.logout()
    res.json
      success: true

module.exports = new SessionController()
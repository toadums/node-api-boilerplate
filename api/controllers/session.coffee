User = require '../models/user'

module.exports =
  # POST /login
  create: (req, res) ->
    console.log "Login attempt"
    res.json
      success: true
      user: req.user

  # GET /logout
  delete: (req, res) ->
    req.logout()
    res.json
      success: true

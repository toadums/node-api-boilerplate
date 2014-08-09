Controller = require './base_controller'
User = require '../models/user'

class UserController extends Controller
  constructor: ->
    @beforeFilters = [
      {method: @isLoggedIn, except:[create]}
    ]

  # POST /u
  create: (req, res) ->

    user =  new User({username: req.body.username, email: req.body.email, password: req.body.password})
    user.save (err) ->
      if err then res.json Error: err
      else res.json {result: "success", user: user}

  # GET /u
  index: (req, res) ->
    User.find (err, users) ->
      if err then res.send err
      res.json users

  # GET /u/:id
  show: (req, res) =>
    User.findById req.params.user_id, (err, user) =>
      if err then res.send err
      unless user and user?._id.equals(req.user?_.id)
        res.json
          err: "Not Authenticated"
      else if user
        res.json
          success: true
          user: user
      else
        res.json
          error: "Not Authenticated"

  # PUT /u/:id
  update: (req, res) ->
    User.findById req.params.user_id, (err, user) ->
      if err then res.send user

      user.name.first = req.body.firstname if req.body.firstname
      user.name.last = req.body.lastname if req.body.lastname

      user.save (err) ->
        if err then res.send err
        res.json message: "User updated: ", user

  # DELETE /u/:id
  destroy: (req, res) ->
    User.remove {_id: req.params.user_id}, (err, user) ->
      if err then res.send err
      res.json {message: "Sucessfully deleted"}

module.exports = new UserController()

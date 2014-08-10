#   GET        /photos           photos#index     display a list of all photos
#   POST       /photos           photos#create    create a new photo
#   GET        /photos/:id       photos#show      display a specific photo
#   PATCH/PUT  /photos/:id       photos#update    update a specific photo
#   DELETE     /photos/:id       photos#destroy   delete a specific photo

_ = require 'underscore'

root.index = 'index'
root.create = 'create'
root.show = 'show'
root.update = 'update'
root.destroy = 'destroy'

_actions = [index, create, show, update, destroy]
_verbs =
  get: "GET"
  post: "POST"
  put: "PUT"
  del: "DELETE"

# Router.resource 'u', controller: 'users', only: ['create', 'show']

class Router
  resource: (path, opts, cb) ->
    unless controller = opts.controller
      return console.log "Must specify a controller"

    # If the user passes in actions, make sure they are correct
    if actions = opts.only
      if (badActions = @checkActions actions).length
        return console.log "Bad actions specified for path /#{path}: #{a for a in badActions}"
    else
      actions = _actions

    @addRoutes path, controller, actions

  # If the user passes in actions, make sure that they are correct
  checkActions: (actions) ->
    badActions = _.without actions, _actions...

  addRoutes: (path, controller, actions) ->
    # Given an array of actions, create some routes
    for action in actions
      @createRoute path, action, controller

  # Create a route for one of the 5 crud actions
  createRoute: (path, action, controller) ->
    beforeFilters = require("../controllers/#{controller}").beforeFilters || []
    actionMethod = require("../controllers/#{controller}")[action]

    methods = []
    # For each before filter, if we would like to run it on the current action, add it to the array
    for filter in beforeFilters
      # Specifying the actions to apply filters to
      if filter.only
        if _.contains(filter.only, action) then methods.push filter.method

      # Specifying the actions you do NOT want to apply filters to
      else if filter.except
        if not _.contains(filter.except, action) then methods.push filter.method

      # Apply to all!
      else
        methods.push filter.method

    # push the actual method
    methods.push actionMethod

    # depending on which action we are working with, figure out how to create the route
    switch action
      when index
        @router.route("/#{path}").get methods
      when create
        @router.route("/#{path}").post methods
      when show
        @router.route("/#{path}/:id").get methods
      when update
        @router.route("/#{path}/:id").put methods
      when destroy
        @router.route("/#{path}/:id").delete methods

module.exports = new Router()





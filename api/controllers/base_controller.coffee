# Not sure how I want to handle things like rails :before_filter, I think this is the place though..

module.exports = class Controller
  find: (req, res) ->
    if not req.user
      res.json
        err: "Not Logged In"

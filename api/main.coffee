express = require 'express'
bodyParser = require 'body-parser'
session = require 'express-session'
config = require "./config/index"

passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
cookieParser = require 'cookie-parser'

User = require './models/user'

app = express()

app.use bodyParser()
app.use cookieParser("Put a secret here..")
app.use session()
port = 3333

router = express.Router()
config.routes router

app.use passport.initialize()
app.use passport.session()

passport.use User.createStrategy()

passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()

app.use '/api', router

app.listen port
console.log "Let's make it rain on: #{port}"

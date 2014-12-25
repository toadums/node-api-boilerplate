global.logger = require("../utils/logger")

express = require 'express'
bodyParser = require 'body-parser'
session = require 'express-session'
cookieParser = require 'cookie-parser'
createRoutes = require './routes'
passport = require './passport'
config = require 'config'
mongoose   = require 'mongoose'

app = express()

app.use bodyParser()
app.use cookieParser()
app.use session
  secret: "Put a secret here.."
  saveUninitialized: true,
  resave: true

port = 3333

router = createRoutes()

mongoose.connect config.get('server.db')
passport app

app.use '/api', router

app.listen port
logger.info "Let's make it rain on: #{port}"

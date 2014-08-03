express = require 'express'
bodyParser = require 'body-parser'
session = require 'express-session'
config = require "./config/index"
cookieParser = require 'cookie-parser'

app = express()

app.use bodyParser()
app.use cookieParser()
app.use session
  secret: "Put a secret here.."
  saveUninitialized: true,
  resave: true

port = 3333

router = express.Router()

config.routes router
config.passport app


app.use '/api', router

app.listen port
console.log "Let's make it rain on: #{port}"

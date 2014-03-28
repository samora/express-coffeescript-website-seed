express = require 'express'
responseTime = require 'response-time'
path = require 'path'
mongoose = require 'mongoose'
lessMiddleware = require 'less-middleware'
MongoStore = require('connect-mongo')(express)
routes = require './config/routes'
middlewares = require './config/middlewares'
settings = require('./config/setup')()

app = express()

# Connect to database
mongoose.connect settings.db, (err, res)->
  if err
    console.log "ERROR: Could not connect to database #{settings.db}"
    console.log err
  else
    console.log "SUCCESS: Connected to database #{settings.db}"

app.set 'views', "#{__dirname}/app/views"
app.set 'view engine', 'jade'
app.use responseTime()
app.use express.favicon()
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session
  secret: 'secret'
  maxAge: 3600000
  store: new MongoStore
    url: settings.db
app.use express.csrf()
app.use middlewares.templateVars()
app.use lessMiddleware path.join __dirname, '/public'

app.use app.router
app.use express.static path.join __dirname, 'public'


# Config: Development only
if 'production' isnt app.get 'env'
  mongoose.set 'debug', true
  app.locals.pretty = true
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

routes app

app.listen settings.port, ()->
  console.log "#{settings.name} listening on port #{settings.port}"
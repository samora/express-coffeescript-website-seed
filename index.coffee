express = require 'express'
responseTime = require 'response-time'
path = require 'path'
routes = require './config/routes'
settings = require('./config/setup')()

app = express()

app.set 'views', "#{__dirname}/app/views"
app.set 'view engine', 'jade'
app.use responseTime()
app.use express.favicon()
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()

app.use app.router
app.use express.static path.join __dirname, 'public'

routes app

app.listen settings.port, ()->
  console.log "#{settings.name} listening on port #{settings.port}"
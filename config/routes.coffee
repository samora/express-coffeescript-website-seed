# Routes

controllers = require '../app/controllers'

module.exports = (app)->
  app.get '/', (req, res)->
    res.render 'index',
      title: 'Welcome'
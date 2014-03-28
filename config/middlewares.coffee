# Middlewares

module.exports =
  validate: ()->
    (req, res, next)->
      req.validate = ()->
        req.validationErrors true

      next()

  templateVars: ()->
    (req, res, next)->
      # Current URL
      res.locals.currentUrl = req.url.toLowerCase()

      # CSRF Token
      res.locals.csrf = req.session._csrf

      # Main Navigation Links
      res.locals.mainNavItems = [
        {text: 'About', url: '/about'}
        {text: 'Contact', url: '/contact'}
      ]

      next()
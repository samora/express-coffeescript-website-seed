# Middlewares

module.exports =
  validate: ()->
    (req, res, next)->
      req.validate = ()->
        req.validationErrors true

      next()
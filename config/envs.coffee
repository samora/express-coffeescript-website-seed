# Environment Configurations

module.exports =
  all:
    name: 'Express CoffeeScript Website'
    port: process.env.PORT or 3000

  development:
    db: 'mongodb://localhost/express_coffeescript_website_development'

  production:
    db: process.env.MONGOLAB_URI or process.env.MONGOHQ_URI

  test:
    db: 'mongodb://localhost/express_coffeescript_website_test'
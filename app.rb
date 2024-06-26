require 'puma'
require 'rack'
require 'rack/handler/puma'
require_relative 'config/routes'
require_relative 'app/controllers/home_controller'

# Define the routes
router = Router.new
router.draw do
  get '/', to: 'home#index'
  get '/about', to: 'home#about'
  get '/*', to: 'home#not_found'
end

# Rack handler for Puma
app = Rack::Handler::Puma

# Options for Puma server
options = {
    Port: ENV['PORT'] || 9292
}

# Run the application with the router
app.run(router, **options)

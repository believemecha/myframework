# app/controllers/home_controller.rb
require 'erb'

class HomeController
    def index
      @message = "Hsjhwgdnhg"
      render 'home/index'
    end

    def about
        render 'home/about'
    end

    def not_found
        render 'home/not_found'
    end
  
    private
  
    def render(view_path)
      template_path = File.join(__dir__, '../views', "#{view_path}.html.erb")
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end
end
  
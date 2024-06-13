# config/routes.rb
class Router
    def initialize
      @routes = {}
    end
  
    def draw(&block)
      instance_eval(&block)
    end
  
    def get(path, to:)
      controller_name, action = to.split('#')
      @routes[path] = { controller: controller_name, action: action }
    end

    def post(path, to:)
      controller_name, action = to.split('#')
      @routes[path] = { controller: controller_name, action: action, method: :post }
    end
  
    def call(env)
      request_path = env['PATH_INFO']
      route = @routes[request_path]
  
      if route
        controller_name = "#{route[:controller].capitalize}Controller"
        action = route[:action]
        controller = Object.const_get(controller_name).new
  
        # Handle different HTTP methods
        case env['REQUEST_METHOD']
        when 'GET'
          response_body = controller.send(action)
          [200, { 'Content-Type' => 'text/html' }, [response_body]]
        when 'POST'
          response_body = controller.send(action)
          [200, { 'Content-Type' => 'text/html' }, [response_body]]
        else
          [405, { 'Content-Type' => 'text/plain' }, ['Method Not Allowed']]
        end
      else
        controller = HomeController.new
        response_body = controller.not_found
        [404, { 'Content-Type' => 'text/html' }, [response_body]]
      end
    end

end
  
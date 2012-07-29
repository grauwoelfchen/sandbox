module Sandbox
  module Helper
    set :haml, :escape_html => true
    def csrf_tag
      Rack::Csrf.csrf_tag(env)
    end
  end
end

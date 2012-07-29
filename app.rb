#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra'
require 'haml'
require 'sass'
%w[app helper].each do |dir|
  require settings.root + "/lib/sandbox/#{dir}"
end

module Sandbox
  configure :development do
    require 'sinatra/reloader'
  end
  configure :production do
    require 'rack/cache'
    use Rack::Cache
    error do
      haml :error
    end
  end
  configure do
    require 'rack/csrf'
    disable :session
    use Rack::Session::Cookie, :secret => ENV['CSRF_TOKEN'] || ':-D'
    use Rack::Csrf, :raise => false
    set :show_exceptions, false
    not_found do
      haml :error
    end
  end
  helpers Sandbox::Helper
end

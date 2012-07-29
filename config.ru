#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra/base'

root_dir = File.expand_path(File.dirname(__FILE__))
Sinatra::Base.set(:root, root_dir)
Sinatra::Base.set(:public_folder, File.join(root_dir, 'public'))
Sinatra::Base.set(:views, File.join(root_dir, 'views'))
Sinatra::Base.set(:run, false)

require root_dir + '/app'

run Sinatra::Application

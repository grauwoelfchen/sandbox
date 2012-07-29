class Object
  def capture(&block)
    origin = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = origin
    end
    fake.string
  end
end
module Sandbox
  get '/' do
    haml :index
  end
  post '/' do
    return '' unless request.xhr?
    @result = proc {
      begin
        capture {
          $SAFE = 3
          eval(params[:code], TOPLEVEL_BINDING, 'sandbox', 1)
        }
      rescue Exception => e
        e.message
      end
    }.call
    haml :result, :layout => false
  end
  get %r{/(style)\.css} do
    sass "#{params[:captures].first}".intern, :style => :compact
  end
end

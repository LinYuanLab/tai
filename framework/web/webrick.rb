#-*- coding:utf-8 -*-


require 'config'


require 'webrick'

#Config
listen = "localhost"
bind_port = 80
document_root = File.dirname(__FILE__)

#Servlets
class RootServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
	resp.body = "<h3>Hello WEBrick</h3>"
  end
end

class ApiServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
	resp.body = "<h3>API</h3>"
  end
  def do_POST( req,resp )
    resp.status = 200
	resp.content_type = "text/plain"
	resp.body = "#{req.body.class}"
  end
end



#core
server = WEBrick::HTTPServer.new(
  :BindAddress => listen,
  :Port => bind_port,
  :DocumentRoot => document_root
)

trap 'INT' do server.shutdown end
server.mount '/', RootServlet
server.mount '/api', ApiServlet
server.start


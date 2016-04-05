#-*- coding:utf-8 -*-

require 'webrick'

require 'config'

#Config
listen = "localhost"
bind_port = 80
document_root = $HTTP_ROOT

#Servlets
class RootServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
	#resp.body = File.new('index.html').sysread(1000)
    IO.foreach("#{$HTTP_ROOT}/index.html") do |line|
        resp.body += line
    end
  end
end

class ApiServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
	#resp.body = "API"
    resp.body = req.body
  end
  def do_POST( req,resp )
    resp.status = 200
	resp.content_type = "text/plain"
	resp.body = "#{req.body.class}"
  end
end

class ResServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
    IO.foreach("#{$HTTP_ROOT}/style.css") do |line|
        resp.body += line
    end
  end
end

class ScriptServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET( req, resp )
    #status, content_type, body = do_stuff_with req
	resp.status = 200
	#resp["Content-Type"] = 'text/plain'
    IO.foreach("#{$HTTP_ROOT}/script.js") do |line|
        resp.body += line
    end
  end
end

class Server < WEBrick::HTTPServer
    def initialize( id, host, port )
        :BindAddress    => host,
        :Port           => port,
        :DocumentRoot   => $HTTP_ROOT
    e
end

#core
server = WEBrick::HTTPServer.new(
  :BindAddress => listen,
  :Port => bind_port,
  :DocumentRoot => document_root
)

trap 'INT' do
    server.shutdown
end

server.mount '/', RootServlet
server.mount '/api', ApiServlet
server.mount '/style.css', ResServlet
server.mount '/script.js', ScriptServlet

server.start

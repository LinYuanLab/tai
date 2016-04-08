#-*- coding:utf-8 -*-

require 'webrick'

require 'config'
require 'servlets'
require 'router'

server = WEBrick::HTTPServer.new(
  :BindAddress => $HTTP_HOST,
  :Port => $HTTP_PORT,
  :DocumentRoot => $HTTP_ROOT
)

trap 'INT' do
    server.shutdown
end

server.mount '/', RootServlet
server.mount '/api', ApiServlet
server.mount '/style.css', ResServlet
server.mount '/script.js', ScriptServlet

server.start

#!/bin/ruby
#-*- coding:utf-8 -*-

require 'socket'




#serv = TCPServer.new("127.0.0.1", 0)
#af, port, host, addr = serv.addr
#c = TCPSocket.new(addr, port)
#s = serv.accept
#c.send "aaa", 0
s = TCPSocket.new "192.168.8.33", 22
begin
  p s.gets(1000) #=> "aaa"
rescue IO::WaitReadable
  IO.select([s])
  retry
end
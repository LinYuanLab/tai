#!/bin/ruby
#-*- coding:utf-8 -*-
#2016-1-22
#Module:alive

require 'icmp4em'

def is_alive(host)
     EM.run do
          manager = ICMP4EM::Manager.new
          request = manager.ping host
          request.callback do 
               #puts "#{host}\tonline"
               return true
          end
          request.errback do |e|
               #puts "#{host}\toffline"
               return false
          end
     end
end

#!/bin/ruby
#-*- coding:utf-8 -*-
#2016-1-22
#Module:live_check.rb

require 'icmp4em'

class Poc
	def initialize
		#puts "#{time} 规则初始化"
	end

	def is_alive(host)
		EM.run do
			manager = ICMP4EM::Manager.new
			request = manager.ping host
			request.callback do 
				puts "#{host}\tonline"
				return true
			end
			request.errback do |e|
				puts "#{host}\toffline"
				return false
			end
		end
	end	
	
	def verify( target )
		begin
			is_alive( target )
		rescue Exception => e
			puts "#{time} #{e}"
		end
	end
end

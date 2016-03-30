#!/bin/ruby
#-*- coding:utf-8 -*-
#2016-1-22
#Module:live_check.rb

require 'icmp4em'

class Vuln
	def initialize
		puts "#{time('%H:%M:%S')} live_check.rb"
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
			puts "#{time('%H:%M:%S')} #{e}"
		end
	end
end

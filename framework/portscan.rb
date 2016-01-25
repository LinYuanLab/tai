#!/bin/ruby
#-*- coding:utf-8 -*-
#2016-1-22
#Module:portscan

require 'thread'


def is_open(host, port, timeout)
	begin
		sock = timeout(timeout){TCPSocket.open(host, port)}
		puts "#{host}:#{port}\tOpen"
		return true
	rescue Exception => e
		return false
	rescue Timeout::Error
		return false
	end
end

def whole_scan( host )
	port = 1
	mutex = Mutex.new
	threads = []
	threadNum = 85
	start_time = Time.now()
	while port <= 65535 do
		threadNum.times do |n|
			threads << Thread.new do 
				mutex.lock
				thread_port = port
				port += 1
				mutex.unlock
				is_open('127.0.0.1', thread_port,3 )
				#puts "线程[#{n}]\t端口[#{thread_port}]"
			end
		end
		threads.each{ |t| t.join }
	end
	end_time = Time.now()
	puts start_time
	puts end_time
end



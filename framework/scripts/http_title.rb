#-*- coding: utf-8 -*-

require 'net/http'


class Poc
	def initialize
		puts "#{time} 规则初始化"
	end

	def verify( target )
		begin
			puts "#{time} 接收到目标 #{target}"
			resp = Net::HTTP.get_response( target )
			reg_title = /<title>(.+?)<\/title>/n
			if resp.code == "200"
				puts resp.body.scan( reg_title )[0]
			end
		rescue
			puts "异常"
		end
	end
end

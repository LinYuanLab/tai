#-*- coding: utf-8 -*-

require 'net/http'

class Poc
	def initialize
		puts "#{time} 规则初始化"
	end

	def verify( target )
		puts target
	end
end

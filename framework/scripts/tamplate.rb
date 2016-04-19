#-*- coding: utf-8 -*-
#file:tamplate.rb

require 'net/http'

class Vuln
	def initialize
		@info				= Hash.new
		@retn				= Hash.new
		@info['vuln_name']	= 'test'
		@info['vuln_type']	= 'misc'
		@info['vuln_date']	= '1970-01-01'
		@info['vuln_refr']	= 'http://'
		@info['vuln_desc']	= 'This vuln is for test'
		@retn['vuln_info']	= @info
		@retn['vuln_vrfy']	= false
		@retn['vuln_data']	= ''
	end

	def verify( target )
		puts "[目标] #{target} 扫描已启动，进程ID 1"
	end

	def ret()
		return @retn['vuln_vrfy']? @retn : nil
	end
end

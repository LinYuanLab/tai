# -*- coding: utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'net/http'

module Spider

	def Spider.getPage(uri,item)
		begin
			resp = Net::HTTP.get_response(formatUri(uri))
			reg_title = /<title>(.*?)<\/title>/n
			page = resp.to_hash
			page["status"]	= resp.code
			page["html"]	= resp.body
			page["title"]	= resp.body.scan(reg_title)
			return page[item]
		rescue
			return nil
		end
	end
	
	def Spider.formatUri(url)
		if url.include?"http://" or url.include?"https:?/"
			return URI(url)
		else
			return URI("http://#{url}")
		end
	end
	
	
	
	
	
end


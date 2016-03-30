#-*- coding: utf-8 -*-

require 'net/http'

module Http
	def Http.getTitle( target )
		begin
			resp = Net::HTTP.get_response( formatUri(target) )
			reg_title = /<title>(.+?)<\/title>/n
			if resp
				puts resp.body.scan( reg_title )[0]
				puts 'http_title'
			end
		rescue Exception => e
			puts "#{time('%H:%M:%S')} #{e}"
		end
	end


	def Http.getPage(uri,item)
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

	def Http.formatUri(url)
		if url.include?"http://" or url.include?"https:?/"
			return URI(url)
		else
			return URI("http://#{url}")
		end
	end

end

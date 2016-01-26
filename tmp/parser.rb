#-*- coding: utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'spider'
require 'model'

module Parser

	def Parser.findUri(html)
		url_list = Array.new
		#html = Spider.getPage(url,"html")
		reg_url = /((http|https):\/\/([\w\d\._-]+\.)+[\w]+([\/\w\d-_\.\?%&=]*)*)/n
		urls = html.scan(reg_url)
		urls.each do |u|
			unless url_list.include?(u[0])
				url_list.push(u[0])
			end
		end
		return url_list
	end

	def Parser.findDomain(html)
		domain_list = Array.new
		#html = Spider.getPage(url,"html")
		reg_domain = /(http|https):\/\/(([\w\d\._-]+\.)+[\w]+)/n
		domains = html.to_s.scan( reg_domain )
		domains.each do |d|
			unless domain_list.include?(d[1])
				domain_list.push(d[1])
			end
		end
		domain = Model::Domain.new
		domain_list.each do |d|
			puts d
			domain.append(d)
		end
	end

	def Parser.parseDomain(domain)
		#reg_ip = /((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/
		reg_ip = /((2[0-4]\d|25[0-5]|[1-9]?\d|1\d{2})\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)/
		d_s =  domain.split(".")
		if domain.match(reg_ip)
			return 0
		elsif d_s.size < 3
			return 1
		elsif d_s.size == 3 and d_s[0] == "www"
			return 1
		elsif d_s.size == 4 and d_s[0] == "www"
			return 1
		elsif d_s.size == 4 and d_s[0] != "www"
			return 2
		else
			return 2
		end
	end

end

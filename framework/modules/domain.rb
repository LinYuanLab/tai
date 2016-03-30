# -*- coding: utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'sqlite3'
require 'Model'

module Domain

	def Domain.getType(domain)
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

	def Domain.append(domain)
		begin
			type = Domain.getType(domain)
			Model.exec("INSERT INTO domains(type, domain) VALUES(#{type},'#{domain}')")
			return true
		rescue Exception => e
			return false
		end
	end
		
	def Domain.remove( key, value )
		begin
			Model.exec( "DELETE FROM domains WHERE #{key} = '#{value}'" )
			#将自增主键减1
			#Model.exec("UPDATE 'main'.'sqlite_sequence' SET seq = ( SELECT seq from 'main'.'sqlite_sequence' WHERE  'name' = 'domains')-1")
		rescue Exception => e
			return false
		end
	end		
		
	def Domain.find( key, value )
		begin
			hash = Hash.new
			row = Model.exec( "SELECT * FROM domains WHERE #{key} = '#{value}' " )
			row.each do |r|
				hash["id"] = r[0]
				hash["name"] = r[1]
				hash["created_at"] = r[2]
			end
			return hash
		rescue Exception => e
			return false
		end
	end
			
	def Domain.update( key, value, where_key, where_value )
		begin
			Model.exec(" UPDATE 'domains' SET #{key} = '#{value}' WHERE  #{where_key} = '#{where_value}' ")
		rescue Exception => e
			return false
		end
	end
	
	def Domain.test()
		puts "test"
	end
	



end #结束模块

#Model.init_db()
#domain = Model::Domain.new
#puts domain.append(ARGV[0])
#domain.append("www.sina.com")
#domain.remove("id", 3)
#domain.remove("domain","www.baidu.com")
#domain.find("id",1)
#domain.find( "domain", "www.baidu.com" )["id"]
#domain.update("domain","www.sina.com","domain","www.weibo.com" )

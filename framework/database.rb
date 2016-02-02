# -*- coding: utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'config'

require 'sqlite3'

module Model

	$model_db = $DB_PATH+"model.sqlite"
	$db = SQLite3::Database.new($model_db)

	def Model.connect()
		return SQLite3::Database.new($model_db)
	end

	def Model.init_db()
		#模型数据库初始化
		#建立数据库文件
		if File::exists?( $model_db )
			File.rename( $model_db, $DB_PATH+"#{Time.now().strftime('%Y%m%d%H%M%s')}#{rand(10)}.sqlite.bak" )
		else
			File.new( $model_db )
			File.chmod( 0755 )
		end
		
		db = SQLite3::Database.new( $model_db )
		#创建域名数据表
		#域名数据库说明
		#id为域名编号
		#type为域名类型，0表示主机，1表示一级域名，2标识二级域名，3表示三级域名
		#domain为主机名
		#created_at记录域名创建时间
		create_domains_table= "CREATE  TABLE 'domains' (
		'id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE DEFAULT 0,
		'type' INTEGER NOT NULL DEFAULT 0,
		'domain' TEXT NOT NULL UNIQUE, 
		'created_at' DATETIME NOT NULL  DEFAULT (datetime('now','localtime')))"
		begin
			db.execute("DROP TABLE domains")
		rescue Exception => e
			puts "第一次建立域名数据表"
		end
		db.execute(create_domains_table)
		
		#创建page数据表
		create_pages_table = "CREATE  TABLE 'pages' (
		'id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE DEFAULT 0,
		'domain_id', INTEGER NOT NULL,
		'uri' TEXT NOT NULL,
		'title' TEXT, 
		'page' TEXT,
		'created_at' DATETIME NOT NULL  DEFAULT (datetime('now', 'localtime')))"
		begin
			db.execute("DROP TABLE pages")
		rescue Exception => e
			puts "第一次建立页面数据表"
		end
		db.execute(create_pages_table)
	end

	def Model.exec(sql)
		sql = strip( sql )
		result = $db.execute(sql)
		return result
	end
	
	def Model.test()
		puts "Model.test"
	end
	
	
	def Model.strip(input)
		#input.delete!("http://")
		#puts input.delete!("")
		return input
	end

	class Domain
		def initialize()
			
		end
		
		def append(domain)
			begin
				type = Parser.parseDomain(domain)
				Model.exec("INSERT INTO domains(type, domain) VALUES(#{type},'#{domain}')")
				return true
			rescue Exception => e
				return false
			end
		end
		
		def remove( key, value )
			begin
				Model.exec( "DELETE FROM domains WHERE #{key} = '#{value}'" )
				#将自增主键减1
				#Model.exec("UPDATE 'main'.'sqlite_sequence' SET seq = ( SELECT seq from 'main'.'sqlite_sequence' WHERE  'name' = 'domains')-1")
			rescue Exception => e
				return false
			end
		end		
		
		def find( key, value )
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
			
		def update( key, value, where_key, where_value )
			begin
				Model.exec(" UPDATE 'domains' SET #{key} = '#{value}' WHERE  #{where_key} = '#{where_value}' ")
			rescue Exception => e
				return false
			end
		end
			
		def test()
			puts @db
		end
		
	end #结束Domain类


end #结束Model模块

#Model.init_db()
#domain = Model::Domain.new
#puts domain.append(ARGV[0])
#domain.append("www.sina.com")
#domain.remove("id", 3)
#domain.remove("domain","www.baidu.com")
#domain.find("id",1)
#domain.find( "domain", "www.baidu.com" )["id"]
#domain.update("domain","www.sina.com","domain","www.weibo.com" )

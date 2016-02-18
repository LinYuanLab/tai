
$LOAD_PATH << File.dirname(__FILE__)

require 'config'
require 'alive'
require 'portscan'

#扫描系统初始化
def init()
	puts "Init"
end

def args_parse(options)
	if output = options[:output]
		puts "Output To File: #{output}"
	end
	if import = options[:import]
		puts "Launch Task:#{import}"
		#执行导入的扫描任务
		create_task( 3, "task_path", targets )
		
	elsif export = options[:export]
		#导出扫描任务
		puts "Export Task:#{export}" 
	elsif list = options[:list]
		#显示对象
		puts "list: #{list}"
	elsif options[:update]
		#更新规则库
		puts "updating..."
	elsif options[:init]
		#初始化本地数据库
		puts "initialize"
	else
		if target = options[:target]
			#这里使用函数对目标进行处理，输出数组格式的任务目标
			targets = parse_target( target )
			
			if rule = options[:rule]
				#如果指定了特定的规则，这里将使用特定的脚本进行扫描
				puts "Load Rule: #{rule}"
				#创建特定规则任务
				create_task( 2, "rule_name", targets )
			else
				if script = options[:script]
					#如果指定了单个脚本进行批量扫描，那么就从这里启动扫描
					puts "Use Script: #{script}"
					create_task( 1, "script_name", targets )
				else
					#不然的话就启动默认规则，从这里进行扫描
					puts "#{time} Load Default Rule"
					#puts Iconv.new('gbk', 'utf-8').iconv("加载" )
					#默认的规则是启用全部的脚本
					create_task( 0, 0, targets )
				end
			end
		else
			#没有指定扫描目标，程序退出
			puts "Target Cannot Be Empty!\n#{time}"
		end
	end
end

#为了推进后面的程序流程临时编写的替代函数
def parse_target( item )
	targets = Array.new
	targets.push( item )
end

#这个才是真正的目标处理函数
#这个函数仅仅把目标处理成数组
#0.如果是单个ip或域名，直接返回成数组
#1.如果是域名类型，类似a.com和a.com,b.com或a.com b.com,自动分割组建数组
#2.如果是网络地址类型，切换成单个ip后组成数组，如192.168.0.0/24，返回的数组内容为192.168.0.1-192.168.0.255
def parse_target_( item )
	reg_domain = /[\w\d\-_\.]+[a-z]{2,4}/n
	reg_ipaddr = /[[0-9]{1,3}\.]{3}\.[0-9]{1,3}/n
	reg_iprang = /[[0-9]{1,3}\.]{3}\.[0-9]{1,3}\/[0-9]{1,2}/n
	if item =~ reg_domain
		puts "DOMAIN: #{item}"
	elsif item =~ reg_ipaddr
		puts "IPADDR: #{item}"
	elsif item =~ reg_iprang
		puts "IPRANGE: #{item}"
	else
		puts "Else"
	end
	
	return item
end

#创建扫描任务
def create_task(type, item, targets)
=begin
该函数参数为：
type:任务类型
	0:默认类型
	1:single scripts
	2:define rule
	3:launch task
item:参数
	type	item		targets
	0		0			targets
	1		script_name	targets
	2		rule_name	targets
	3		task_path	null
targets:目标，数组类型
=end
	case type
		when 0
			puts "#{time} Default Task"
			
		when 1
			puts "script task"
		when 2
			puts "rule task"
		when 3
			puts "launch task"
		else
			puts "unknow task"
		end
	targets.each do | target |
		puts target
	end
end

def time(*item)
	case item
		when 0
			return Time.now.strftime('%Y-%m-%d %H:%M:%S')
		when 1
			return Time.now.strftime('%Y/%m/%d %H:%M:%S')
		when 2
			return Time.now.strftime('%Y%m%d %H:%M:%S')
		else
			return Time.now.strftime('%H:%M:%S')
		end
end


#检查版本和规则更新
def version(obj)
	version = Hash.new
	version["framework"] = "0.0.0"
	version["rules"]	= "20160104"
	return version[obj]
end

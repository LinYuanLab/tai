#!/bin/ruby

#-*- coding:utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'config'
require 'alive'
require 'portscan'

#扫描系统初始化
def init()
	puts "Start"
end

#处理脚本参数
def args_parse(options)
	#指定扫描脚本
	if script = options[:script]
		puts "script: #{script}"
	end
	#指定扫描规则
	if rule = options[:rule]
		puts "rule: #{rule}"
	end
	#指定扫描目标
	if target = options[:target]
		whole_scan( target )
		#get_info( target, 80 )
	end
	#导入扫描任务
	if import = options[:import]
		puts "import:#{import}"
	end
	#导出扫描任务
	if export = options[:export]
		puts "export #{export}"
	end
	#将扫描结果输出到文件
	if output = options[:output]
		puts "output: #{output}"
	end
	#显示对象
	if list = options[:list]
		puts "list: #{list}"
	end
	#更新规则库
	if options[:update]
		puts "updating..."
	end
	#初始化本地数据库
	if options[:init]
		puts "initialize"
	end
	#options.each do | k,v |
	#	puts "#{k}=>#{v}"
	#end
end

def parse_ip(item)
  puts item
end


#检查版本和规则更新
def version(obj)
	version = Hash.new
	version["framework"] = "0.0.0"
	version["rules"]	= "20160104"
	return version[obj]
end

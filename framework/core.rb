#!/bin/ruby
#-*- coding:utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'config'


#扫描系统初始化
def init()
	puts "Start"
end

#处理脚本参数
def args_parse(options)
	options.each do | k,v|
		puts "#{k}=>#{v}"
	end
end

#调用nmap扫描主机是否存活
def nmap_alive_detect()
	
	
end



#检查版本和规则更新
def version(obj)
	version = Hash.new
	version["framework"] = "0.0.0"
	version["rules"]	= "20160104"
	return version[obj]
end

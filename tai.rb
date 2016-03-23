#-*- coding:utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'framework/core'

require 'optparse'

options = {}
OptionParser.new do |parser|
	#parser.separator("\noptions:")
	parser.on( "-s", "--script SCRIPT", "指定脚本进行扫描" ) do |script|
		options[:script] = script
	end

	parser.on( "-r", "--rule RULE", "指定规则进行扫描" ) do |rule|
		options[:rule] = rule
	end
          
	parser.on( "-t", "--target TARGET", "指定目标" ) do |target|
		options[:target] = target
	end
	
	parser.on( "-p", "--port PORT", "指定端口(用于web扫描)" ) do |port|
		options[:port] = port
	end
	#parser.on( "-i", "--import FILE", "导入扫描任务") do |import|
	#     options[:import] = import
	#end
     
	#parser.on( "-e", "--export FILE", "导出扫描任务") do |export|
	#     options[:export] = export
	#end     
     
	#parser.on( "-o", "--output FILE", "将扫描结果输出到文件") do |output|
	#     options[:output] = output
	#end

	parser.on( "-l", "--list [scripts|rules|tasks]", "显示脚本/规则/任务") do |list|
		options[:list] = list
	end
     
	parser.on( "--update", "更新规则库") do
		options[:update] = true
	end

	parser.on(  "--init", "初始化本地数据库") do
		options[:init] = true
	end

	parser.on("-h", "--help", "显示该帮助信息") do
		puts parser
		exit
	end

	parser.on("-v", "--version", "显示版本信息") do
		puts "主程序版本: #{version("framework")}"
		puts "规则库版本: #{version("rules")}"
		exit
	end
end.parse!

args_parse(options)









#-*- coding:utf-8 -*-

$LOAD_PATH << File.dirname(__FILE__)

require 'framework/core'

options = {}
OptionParser.new do |parser|
	parser.separator("\n[ 扫描模式选项 ]")
	parser.on( "-s", "--script SCRIPT", "指定特定脚本进行扫描" ) do |script|
		options[:script] = script
	end

	parser.on( "-r", "--rule RULE", "指定特定规则进行扫描" ) do |rule|
		options[:rule] = rule
	end

	parser.separator("\n[ 扫描目标选项 ]")
	parser.on( "-t", "--target TARGET", "设置目标" ) do |target|
		options[:target] = target
	end

	parser.on( "-T", "--thread n", "设置扫描线程数量" ) do |thread|
		options[:thread] = thread
	end

	parser.on( "-p", "--port PORT", "设置端口(用于web扫描)" ) do |port|
		options[:port] = port
	end

	parser.separator("\n[ 扫描任务选项 ]")
	parser.on( "-i", "--import FILE", "导入扫描任务") do |import|
	     options[:import] = import
	end

	parser.on( "-e", "--export FILE", "导出扫描任务") do |export|
	     options[:export] = export
	end

	parser.on( "-o", "--output FILE", "将扫描结果输出到文件") do |output|
	     options[:output] = output
	end

	parser.separator("\n[ 扫描器选项 ]")
	parser.on( "-w", "--web", "启动web服务") do |web|
		 options[:web] = web
	end

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

	parser.on("-d", "--debug", "显示调试信息") do
		debug()
		exit
	end

	parser.on("-v", "--version", "显示版本信息") do
		puts "主程序版本: #{version("framework")}"
		puts "规则库版本: #{version("rules")}"
		exit
	end

	parser.separator("\n[ 上帝模式 ]")
	parser.on( "-W", "--wooyun", "乌云厂商一键检测") do |output|
		 options[:output] = output
	end
end.parse!

parse_args(options)

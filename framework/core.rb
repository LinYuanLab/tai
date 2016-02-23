
$LOAD_PATH << File.dirname(__FILE__)

require 'log'
require 'config'
require 'alive'
require 'tasks'
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
				puts "加载规则: #{rule}"
				#创建特定规则任务
				create_task( 2, "rule_name", targets )
			else
				if script = options[:script]
					#如果指定了单个脚本进行批量扫描，那么就从这里启动扫描
					puts "Use Script: #{script}"
					create_task( 1, "script_name", targets )
				else
					#不然的话就启动默认规则，从这里进行扫描
					puts "#{time} 加载默认规则"
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

#返回当前时间
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

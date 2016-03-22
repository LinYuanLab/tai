
$LOAD_PATH << File.dirname(__FILE__)

require 'tasks'
require 'scans'
require 'config'

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
		case list
		when 'scripts'
			puts "当前共#{(Dir.entries $SCRIPT_PATH).size-2}个扫描脚本"
			(Dir.entries $SCRIPT_PATH).each do |script|
				unless script == '.' or script == '..'
					puts "[] #{script}"
				end
			end
		when 'rules'
			puts "#{time} 当前共#{(Dir.entries $RULE_PATH).size-2}条扫描规则"		
		when 'tasks'
			puts "#{time} 当前共#{(Dir.entries $PROC_PATH).size-2}个扫描进程"		
		end
	elsif options[:update]
		#更新规则库
		puts "updating..."
	elsif options[:init]
		#初始化本地数据库
		puts "initializing..."
	else
		if target = options[:target]
			#这里使用函数对目标进行处理，输出数组格式的任务目标
			targets = parse_target( target )
			if rule = options[:rule]
				#如果指定了特定的规则，这里将使用特定的脚本进行扫描
				#puts "#{time} 加载规则: #{rule}"
				#创建特定规则任务
				create_task( 2, rule, targets )
			else
				if script = options[:script]
					#如果指定了单个脚本进行批量扫描，那么就从这里启动扫描
					#puts "Use Script: #{script}"
					create_task( 1, script, targets )
				else
					#不然的话就启动默认规则，从这里进行扫描
					#puts "#{time} 加载默认规则"
					#puts Iconv.new('gbk', 'utf-8').iconv("加载" )
					#默认的规则是启用全部的脚本
					create_task( 0, 0, targets )
				end
			end
		else
			#没有指定扫描目标，程序退出
			puts "#{time} 使用 -h 或 --help 查看帮助"
		end
	end
end

#返回系统时间
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


=begin
puts "\033[1mFront\033[0m\n"  
puts "   \033[30mBlack (30)\033[0m\n"  
puts "   \033[31mRed (31)\033[0m\n"  
puts "   \033[32mGreen (32)\033[0m\n"  
puts "   \033[33mYellow (33)\033[0m\n"  
puts "   \033[34mBlue (34)\033[0m\n"  
puts "   \033[35mMagenta (35)\033[0m\n"  
puts "   \033[36mCyan (36)\033[0m\n"  
puts "   \033[37mWhite (37)\033[0m\n"  
puts ''   
puts "\033[1mBackend\033[0m\n"  
puts "   \033[40m\033[37mBlack (40), White Text\033[0m\n"  
puts "   \033[41mRed (41)\033[0m\n"  
puts "   \033[42mGreen (42)\033[0m\n"  
puts "   \033[43mYellow (43)\033[0m\n"  
puts "   \033[44mBlue (44)\033[0m\n"  
puts "   \033[45mMagenta (45)\033[0m\n"  
puts "   \033[46mCyan (46)\033[0m\n"  
puts "   \033[47mWhite (47)\033[0m\n"  
puts ''  
puts "\033[1mOther\033[0m\n"
puts "   Reset (0)"  
puts "   \033[1mBold (1)\033[0m\n"
puts "   \033[4mUnderlined (4)\033[0m\n"
=end





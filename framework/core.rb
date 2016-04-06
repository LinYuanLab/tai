
$LOAD_PATH << File.dirname(__FILE__)

require 'tasks'
require 'scans'
require 'config'

require 'ip'
require 'json'
require 'thread'
require 'optparse'

$CONFIG = {}

#扫描系统初始化
def init()
	puts "Init"
end

#解析输入选项
def parse_args(options)

	$CONFIG['thread'] = options[:thread] ? options[:thread].to_i : 10

	if output = options[:output]
		puts "Output To File: #{output}"
	end

	if options[:web]
		puts "#{$HTTP_ROOT}"
		require 'web/server'
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
				Task.new( 2, rule, targets )
			else
				if script = options[:script]
					#如果指定了单个脚本进行批量扫描，那么就从这里启动扫描
					Task.new( 1, script, targets )
				else
					#否则启动默认规则，从这里进行扫描，默认的规则是启用全部的脚本
					Task.new( 0, 0, targets )
				end
			end
		else
			#没有指定扫描目标，程序退出
			puts "#{time('%H:%M:%S')} 使用 -h 或 --help 查看帮助"
		end
	end
end

#解析扫描规则
def parse_rule( rule_id )
	begin
		rule			= Hash.new
		rule['id']		= rule_id.to_i
		rule['file']	= "#{$RULE_PATH}/#{rule['id']}"
		rule['name']	= IO.readlines( rule['file'] )[0].delete("#") #规则文件的第一行为脚本的名称
		scripts			= Array.new
		#规则为/rules/下的描述文件，其中的每一行存储一个脚本名称
		IO.foreach( rule['file'] ) do | s |
			unless s.match(/^#/)
				#去掉以"#"开头的行
				scripts.push( s.chomp )
			end
		end
		rule['scripts'] = scripts
		return rule
	rescue
		puts "#{time('%H:%M:%S')} 规则有误"
		exit
	end
end

#解析扫描目标
def parse_target( item )
	targets = Array.new
	if File.exist?( item )
		IO.foreach( item ) do |line|
			targets += parse_ipaddr( line.chomp )
		end
	else
		targets = parse_ipaddr( item )
	end
	return targets
end

#解析ip地址
def parse_ipaddr( item )
	targets = Array.new
	if item.split().size >= 2
		start = item.split()[0]
		stop = item.split()[1]
		ips =  IP::Range[ start,stop ]
		ips.each do |ip|
			#unless ip.ip_address.split('.')[3] == "0"
			targets.push( ip.ip_address )
			#end
		end
	elsif item.include?','
		#x.x.x.x,y.y.y.y,z.z.z.z
		item.split(",").each do |target|
			targets.push( target )
		end
	elsif item.include?'-'
		#x.x.x.x-y.y.y.y
		start = item.split("-")[0]
		stop = item.split("-")[1]
		ips =  IP::Range[ start,stop ]
		ips.each do |ip|
			targets.push( ip.ip_address )
		end
	elsif item.include?'/'
		#x.x.x.x/y
		ips = IP::CIDR.new( item )
		ips.range.each do |ip|
			targets.push( ip.ip_address )
		end
	elsif item.include?':'
		#x.x.x.x:xx
	else
		targets.push( item )
	end
	return targets
end



#返回系统时间
def time(item)
	case item
		when 0
			return Time.now.strftime('%Y-%m-%d %H:%M:%S')
		when 1
			return Time.now.strftime('%Y/%m/%d %H:%M:%S')
		when 2
			return Time.now.strftime('%Y%m%d %H:%M:%S')
		when 3
			return Time.now.strftime("%Y%m%d%H%M%S")
		when 4
			return Time.now.to_i
		when 5
			return "#{time(3)}#{Time.now.to_i}"
		when 6
			return Time.now.to_f
		else
			return Time.now.strftime(item)
		end
end

#检查版本和规则更新
def version(obj)
	version = Hash.new
	version["framework"] = "0.0.0"
	version["rules"]	= "20160104"
	return version[obj]
end

def update()
	puts "run git pull"
end

def debug()
	puts "*"*64
	puts "[   配置   ]"
	puts "$WORK_PATH\t#{$WORK_PATH}"
	puts "$LOGS_PATH\t#{$LOGS_PATH}"
	puts "$PROC_PATH\t#{$PROC_PATH}"
	puts "$RULE_PATH\t#{$RULE_PATH}"
	puts "$MODULE_PATH\t#{$MODULE_PATH}"
	puts "$SCRIPT_PATH\t#{$SCRIPT_PATH}"
	puts "$DATABASE_PATH\t#{$DATABASE_PATH}"
	puts "$LOAD_PATH:"
	puts $LOAD_PATH
	puts "*"*64
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

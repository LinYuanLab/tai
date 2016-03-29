$LOAD_PATH << File.dirname(__FILE__)

require 'ip'
require 'scans'

def parse_target( item )
	targets = Array.new
	if File.exist?( item )
		IO.foreach( item ) do |line|
			if line.split().size >= 2
				start = line.split()[0]
				stop = line.split()[1]
				ips =  IP::Range[ start,stop ]
				ips.each do |ip|
					#unless ip.ip_address.split('.')[3] == "0"
						targets.push( ip.ip_address )
					#end
				end
			else
				if line.include?'/'
					ips = IP::CIDR.new( line.chomp )
					ips.range.each do |ip|
						#unless ip.ip_address.split('.')[3] == "0"
							targets.push( ip.ip_address )
						#end
					end
				else
					targets.push( line.chomp )
				end
			end
		end
	elsif item.include?','
		item.split(",").each do |target|
			targets.push( target )
		end
	elsif item.include?'-'
		start = item.split("-")[0]
		stop = item.split("-")[1]
		ips =  IP::Range[ start,stop ]
		ips.each do |ip|
			#unless ip.ip_address.split('.')[3] == "0"
				targets.push( ip.ip_address )
			#end
		end
	elsif item.include?'/'
		ips = IP::CIDR.new( item )
		ips.range.each do |ip|
			#unless ip.ip_address.split('.')[3] == "0"
				targets.push( ip.ip_address )
			#end
		end
	else
		targets.push( item )
	end
	return targets
end


=begin
#创建扫描任务
该函数参数为：
type:任务类别(数字类型)
	0:default mode(默认类型	)	启用全部扫描规则
	1:single scripts(单脚本模式)	指定脚本进行扫描
	2:define rule(指定规则模式)	加载规则中指定的脚本进行扫描
	3:launch task(导入任务)	从保存的任务中导入扫描
item:任务参数(数字类型)
	type	item		targets
	0		0			targets
	1		script_name	targets
	2		rule_name	targets
	3		task_path	null
targets:目标(数组类型)
=end
def create_task(type, item, targets)
	case type
		when 0
			#puts "#{time} 加载全部脚本#{item}扫描 #{targets.size} 个目标"
			create_task( 2, 0, targets )
		when 1
			scripts = []
			scripts.push(item)
			create_scan( targets, scripts )
			#puts "#{time} 使用脚本 #{item} 扫描 #{targets.size} 个目标"
			#targets.each do |target|
				#require item
				#poc = Poc.new
				#poc.verify( target )
				#scan = Scan.new(target, item)
			#end
		when 2
			rule = parse_rule( item.to_i )
			create_scan( targets, rule['scripts'] )
			#puts "#{time} 加载规则#{item}扫描 #{targets.size} 个目标"
			#targets.each do | target |
				#puts "#{time} 当前规则:#{rule['name']}"
				#puts "#{time} 规则文件路径:#{rule['file']}"
				#rule['scripts'].each do |script|
					#这里稍后加上多线程，每一个线程中实例化一个变量
					#puts "#{time} 使用 #{script} 扫描 #{target}"
					#require script
					#poc = Poc.new
					#puts Poc.info['id']
					#poc.verify( target )
				#end
			#end
		when 3
			puts "#{time} Launch Task #{item} #{targets}"
		else
			puts "#{time} Unknow Command #{item} #{targets}"
		end
end

#根据targets数量创建多线程
def create_scan( targets, scripts )
	threads = []
	while targets.size > 0
		$TASK_THREAD.times do |i|
			threads << Thread.new do
				target = targets.size >0 ? targets.pop : nil
				unless !target
					scan = Scan.new( targets.pop, scripts )
				end
			end
			threads.each{|t| t.join }
		end
	end
end

def parse_rule( rule_id )
	begin
		rule = Hash.new
		rule['id']	 = rule_id.to_i
		rule['file'] = "#{$RULE_PATH}/#{rule['id']}"
		rule['name'] = IO.readlines( rule['file'] )[0].delete("#") #规则文件的第一行为脚本的名称
		scripts = Array.new
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
		puts "#{time} 规则有误"
		exit
	end
end

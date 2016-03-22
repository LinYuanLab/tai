$LOAD_PATH << File.dirname(__FILE__)

require 'ip'

def parse_target( item )
	targets = Array.new
	if File.exist?( item )
		IO.foreach( item ) do |line|
			if line.split().size >= 2
				start = line.split()[0]
				stop = line.split()[1]
				ips =  IP::Range[ start,stop ]
				ips.each do |ip|
					targets.push( ip.ip_address )
				end
			else
				if line.include?'/'
					ips = IP::CIDR.new( line.chomp )
					ips.range.each do |ip|
						targets.push( ip.ip_address )
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
			targets.push( ip.ip_address )
		end
	elsif item.include?'/'
		ips = IP::CIDR.new( item )
		ips.range.each do |ip|
			targets.push( ip.ip_address )
		end
	else
		targets.push( item )
	end
	return targets
end

#创建扫描任务
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
def create_task(type, item, targets)
	case type
		when 0
			#默认扫描类型
			#启用全部扫描规则
			#puts "#{time} 加载全部脚本#{item}扫描 #{targets.size} 个目标"
			create_task( 2, 0, targets )
		when 1
			#单脚本模式
			#这种模式下通过判断规则中包含的目标数量来创建扫描线程
			#puts "#{time} 使用脚本 #{item} 扫描 #{targets.size} 个目标"
			targets.each do |target|
				require item
				poc = Poc.new
				poc.verify( target )
			end
		when 2
			#规则模式
			#这种模式下通过判断规则中包含的脚本数量来处理扫描线程
			#puts "#{time} 加载规则#{item}扫描 #{targets.size} 个目标"
			targets.each do | target |
				rule = parse_rule( item.to_i )
				#puts "#{time} 当前规则:#{rule['name']}"
				#puts "#{time} 规则文件路径:#{rule['file']}"
				rule['scripts'].each do |script|
					#这里稍后加上多线程，每一个线程中实例化一个变量
					#puts "#{time} 使用 #{script} 扫描 #{target}"
					require script
					poc = Poc.new
					#puts Poc.info['id']
					poc.verify( target )
				end
			end
		when 3
			#任务模式(可以归类到上面的模式中)
			puts "#{time} Launch Task #{item} #{targets}"
		else
			puts "#{time} Unknow Command #{item} #{targets}"
		end
end

def parse_rule( rule_id )
	rule = Hash.new
	rule['id']	 = rule_id.to_i
	rule['file'] = "#{$RULE_PATH}/#{rule['id']}"
	rule['name'] = IO.readlines( rule['file'] )[0].delete("#")
	scripts = Array.new
	#规则为/rules/下的描述文件，其中的每一行存储一个脚本名称
	IO.foreach( rule['file'] ) do | s |
		unless s.match(/^#/)
			scripts.push( s.chomp )
		end
	end
	rule['scripts'] = scripts
	return rule
end
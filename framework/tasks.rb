$LOAD_PATH << File.dirname(__FILE__)

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
			puts "#{time} Default Task #{item} For #{targets}"
			create_task(2, 0, targets )
		when 1
			#单脚本模式
			#这种模式下通过判断规则中包含的目标数量来创建扫描线程
			puts "#{time} Use Script #{item} #{targets}"
		when 2
			#规则模式
			#这种模式下通过判断规则中包含的脚本数量来处理扫描线程
			puts "#{time} Use Rule #{item} For #{targets}"
			targets.each do | target |
				rule = parse_rule( item.to_i )
				puts "#{time} Rule Name #{rule['name']}"
				puts "#{time} Rule File In #{rule['file']}"
				rule['scripts'].each do |script|
					puts "#{time} #{script} -> #{target}"
					require script
					p = Poc.new
					p.verify( target )
				end
			end
		when 3
			#任务模式(可以归类到上面的模式中)
			puts "#{time} Launch Task #{item} #{targets}"
		else
			puts "#{time} Unknow Command #{item} #{targets}"
		end
end

def parse_rule(rule_id)
	rule = Hash.new
	rule['id']	 = rule_id.to_i
	rule['file'] = "#{$RULE_PATH}/#{rule['id']}"
	rule['name'] = "RULE:#{rule_id}"
	scripts = Array.new
	#规则为/rules/下的描述文件，其中的每一行存储一个脚本名称
	#规则文件的命名方式为 id-name.rule,如 0:default.rule
	IO.foreach( rule['file'] ) do | s |
		scripts.push( s.chomp )
	end
	rule['scripts'] = scripts
	return rule
end

def getRuleNameById( id )

end




$LOAD_PATH << File.dirname(__FILE__)

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
class Task
	@@task_count = 0
	def initialize(type, item, targets)
		@@task_count		+= 1
		$CONFIG['task_id']	= @task_id = "#{time(3)}#{@@task_count}"
		mk_task_dir()
		case type
			when 0
				rule = parse_rule( 0 )
				create_scan( targets, rule['scripts'] )
			when 1
				scripts = []
				scripts.push(item)
				create_scan( targets, scripts )
			when 2
				rule = parse_rule( item.to_i )
				create_scan( targets, rule['scripts'] )
			when 3
				puts "#{time} Launch Task #{item} #{targets}"
			else
				puts "#{time} Unknow Command #{item} #{targets}"
			end
	end

	def create_scan( targets, scripts )
		threads = []
		while targets.size > 0
			$CONFIG['thread'].times do |i|
				threads << Thread.new do
					target = targets.size >0 ? targets.pop : nil
					unless !target
						scan = Scan.new( target, scripts )
					end
				end
				threads.each{|t| t.join }
			end
		end
	end

	def mk_task_dir()
		$CONFIG['taskdir'] = "#{$TASK_PATH}/#{$CONFIG['task_id']}"
		Dir::mkdir( $CONFIG['taskdir'], mode=0700 )
	end
end

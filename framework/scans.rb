$LOAD_PATH << File.dirname(__FILE__)

class Scan
	@@scan_count = 0
	def initialize( target, scripts )
		@@scan_count 	+= 1
		@info			= Hash.new
		threads			= Array.new
		@scan_file		= "#{$CONFIG['taskdir']}/#{target}.json"
		@info['id']		= @scan_id = @@scan_count
		@info['task']	= $CONFIG['task_id']
		@info['vulns']	= Array.new
		@info['target']	= target
		while scripts.size > 0
			$CONFIG['thread'].times do |i|
				threads << Thread.new do
					script = scripts.size >0 ? scripts.pop : nil
					unless !script
						scan( target, script )
					end
				end
				threads.each{|t| t.join }
			end
		end
		save()
	end

	def scan( target, script )
		require script
		vuln = Vuln.new
		vuln.verify( target )
		@info['vulns'].push( vuln.ret )
	end

	def save( )
		puts @info.to_json
		f = File::new( @scan_file, 'a+' )
		f.syswrite( @info.to_json )
		f.close
	end

end

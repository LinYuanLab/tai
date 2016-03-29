$LOAD_PATH << File.dirname(__FILE__)

require 'ip'

class Scan
	def initialize( target, scripts )
		threads = []
		while scripts.size > 0
			$SCAN_THREAD.times do |i|
				threads << Thread.new do
					script = scripts.size >0 ? scripts.pop : nil
					unless !script
						scan( target, script )
					end
				end
				threads.each{|t| t.join }
			end
		end
	end

	def scan( target, script )
		require script
		poc = Poc.new
		poc.verify( target )
	end

	def save()

	end

end

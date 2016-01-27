require 'socket'

s = TCPSocket.new 'localhost', 9999

loop do
	while recv = s.gets
		puts "服务器返回:#{recv}"
		print ">"
		if input = gets
			if input.chomp == "exit"
				exit
			else
				s.puts input
			end
		end
	end
end
s.close



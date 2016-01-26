require 'socket'

server = TCPServer.new 9999 # Server bound to port 2000

loop do
	client = server.accept    # Wait for a client to connect
	while line = client.gets
		if line == "exit"
			client.close
		else
			client.puts "Time is #{Time.now}"
			puts line
		end
	end
end

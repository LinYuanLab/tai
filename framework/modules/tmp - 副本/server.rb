require 'socket'

server = TCPServer.new 9999

loop do
	client = server.accept
	puts "客户端上线:#{client.addr[2]}"
	client.puts Time.now()
	while line = client.gets
		puts "客户端输入:#{line.chomp}"
		client.puts line
	end
end

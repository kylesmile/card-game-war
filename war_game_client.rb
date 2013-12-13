require 'socket'

class WarGameClient
	CONTROL_SEQUENCE = 'END'
	def initialize(host='10.0.0.54', port=51528)
		@socket = TCPSocket.new(host, port)
	end

	def get_server_input
		buffer = ''
		while line = @socket.gets
			buffer << line.split(CONTROL_SEQUENCE).first
			break if line =~ /#{CONTROL_SEQUENCE}/
		end
		buffer
	end

	def send_message(message = $stdin.gets)
		@socket.puts(message)
	end

	def display_server_input
		$stdout.puts(get_server_input)
	end
end
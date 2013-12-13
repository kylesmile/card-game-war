require_relative './war_game_server'

server = WarGameServer.new
server.accept_new_client
server.accept_new_client

loop do
	server.take_commands
end
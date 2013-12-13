require_relative './war_game_client'

client = WarGameClient.new

loop do
	client.display_server_input
	client.send_message('')
end
require_relative './war_game_client'

puts "Press enter to play a card"
puts "The round results will be displayed after both players have played"

client = WarGameClient.new

loop do
	client.display_server_input
	client.send_message
end
require_relative './war_game_server'

class WarGame # Cheat to make testing feasible
	def rig_cards(player1_cards, player2_cards)
		@players[0].set_cards(player1_cards)
		@players[1].set_cards(player2_cards)
	end
end

class WarPlayer
	def set_cards(cards)
		@cards = cards
	end
end

server = WarGameServer.new
server.accept_new_client
server.accept_new_client

hand1 = [PlayingCard.new('A', 'S'), PlayingCard.new('3', 'S')]
hand2 = [PlayingCard.new('2', 'C'), PlayingCard.new('3', 'C')]
server.game.rig_cards(hand1, hand2)

loop do
	server.take_commands
end
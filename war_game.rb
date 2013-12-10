class WarGame
	attr_reader :winner

	def initialize
		@winner = nil
	end

	def play_round(player1, player2, cards=[])
		card1 = player1.play_top_card
		card2 = player2.play_top_card
		
		cards.push(card1, card2)
		cards.compact!

		if (card1.nil? && card2.nil?)
			@winner = "Tie"
		elsif (card2.nil?)
			@winner = "Player 1"
		elsif (card1.nil?)
			@winner = "Player 2"
		elsif (card1.value > card2.value)
			player1.take_cards(cards)
		elsif (card2.value > card1.value)
			player2.take_cards(cards)
		else
			play_round(player1, player2, cards)
		end
	end
end
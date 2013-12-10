class WarGame
	attr_reader :winner, :player1, :player2

	def initialize(player1 = WarPlayer.new, player2 = WarPlayer.new)
		@player1, @player2 = player1, player2
	end

	def deal
		deck = CardDeck.new
		deck.shuffle
		@player1.take_cards(deck.deal(26))
		@player2.take_cards(deck.deal(26))
	end

	def play_game
		while @winner.nil?
			play_round
		end
	end

	def play_round(cards=[])
		card1 = @player1.play_top_card
		card2 = @player2.play_top_card
		
		cards.push(card1, card2)
		cards.compact!

		if (card1.nil? && card2.nil?)
			@winner = "Tie"
		elsif (card2.nil?)
			@winner = "Player 1"
		elsif (card1.nil?)
			@winner = "Player 2"
		elsif (card1.value > card2.value)
			@player1.take_cards(cards)
		elsif (card2.value > card1.value)
			@player2.take_cards(cards)
		else
			play_round(cards)
		end
	end
end
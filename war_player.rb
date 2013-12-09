class WarPlayer
	def initialize(card)
		@cards = [card]
	end

	def number_of_cards
		@cards.count
	end

	def play_top_card
		@cards.pop
	end

	def take_cards(cards)
		@cards.push(*cards)
	end
end
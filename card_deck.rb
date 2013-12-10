class CardDeck
	CardRanks = %w(2 3 4 5 6 7 8 9 10 J Q K A)
	def initialize
		@cards = PlayingCard::RANKS.map do |rank|
			PlayingCard::SUITS.map do |suit|
				PlayingCard.new(rank, suit)
			end
		end.flatten
	end

	def has_cards?
		@cards.count > 0
	end

	def deal(n=1)
		@cards.pop(n)
	end

	def shuffle
		@cards.shuffle!
	end

	def number_of_cards
		@cards.count
	end
end
require_relative 'playing_card'

class CardDeck
	CardRanks = %w(2 3 4 5 6 7 8 9 10 J Q K A)
	def initialize
		@cards = []
		4.times do
			CardRanks.each do |rank|
				@cards << PlayingCard.new(rank)
			end
		end
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
end
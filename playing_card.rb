class PlayingCard
	RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
	SUITS = %w(C H D S)
	def initialize(rank, suit='C')
		@rank, @suit = rank, suit
	end

	def value
		RANKS.index(@rank)
	end
end
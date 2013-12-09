class PlayingCard
	CardRanks = %w(2 3 4 5 6 7 8 9 10 J Q K A)
	def initialize(rank)
		@rank = rank
	end

	def value
		CardRanks.index(@rank)
	end
end
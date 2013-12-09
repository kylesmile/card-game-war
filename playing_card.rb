class PlayingCard
	def initialize(rank)
		@rank = rank
	end

	def value
		%w(2 3 4 5 6 7 8 9 10 J Q K A).index(@rank)
	end
end
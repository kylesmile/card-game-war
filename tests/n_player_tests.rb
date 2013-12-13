require 'minitest/autorun'
require_relative '../war_game'

class TestNPlayers < MiniTest::Unit::TestCase

	def test_player3_wins
		war = WarGame.new(WarPlayer.new([PlayingCard.new('K')]), WarPlayer.new([PlayingCard.new('2')]), WarPlayer.new([PlayingCard.new('A')]))
		war.play_round
		assert_equal(0, war.player(0).number_of_cards)
		assert_equal(0, war.player(1).number_of_cards)
		assert_equal(3, war.player(2).number_of_cards)
	end

end
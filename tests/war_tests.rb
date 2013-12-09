require 'minitest/autorun'
Dir[File.dirname(__FILE__) + '/../*.rb'].each { |file| require_relative "../#{file}"}

class TestWar < MiniTest::Unit::TestCase
	def setup
		@war = WarGame.new
	end

	def test_player1_wins
		player1 = WarPlayer.new(PlayingCard.new('A'))
		player2 = WarPlayer.new(PlayingCard.new('2'))
		@war.play_round(player1, player2)
		assert_equal(2, player1.number_of_cards)
		assert_equal(0, player2.number_of_cards)
	end

	def test_player2_wins
		player1 = WarPlayer.new(PlayingCard.new('2'))
		player2 = WarPlayer.new(PlayingCard.new('3'))
		@war.play_round(player1, player2)
		assert_equal(0, player1.number_of_cards)
		assert_equal(2, player2.number_of_cards)
	end
end
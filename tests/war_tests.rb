require 'minitest/autorun'
Dir[File.dirname(__FILE__) + '/../*.rb'].each { |file| require_relative "../#{File.basename(file)}"}

class TestWar < MiniTest::Unit::TestCase

	def test_player1_wins
		war = WarGame.new(WarPlayer.new([PlayingCard.new('A')]), WarPlayer.new([PlayingCard.new('2')]))
		war.play_round
		assert_equal(2, war.player(0).number_of_cards)
		assert_equal(0, war.player(1).number_of_cards)
	end

	def test_player2_wins
		war = WarGame.new(WarPlayer.new([PlayingCard.new('2')]), WarPlayer.new([PlayingCard.new('3')]))
		war.play_round
		assert_equal(0, war.player(0).number_of_cards)
		assert_equal(2, war.player(1).number_of_cards)
	end

	def test_player1_wins_longer_round
		player1 = WarPlayer.new([PlayingCard.new('A'), PlayingCard.new('5')])
		player2 = WarPlayer.new([PlayingCard.new('Q'), PlayingCard.new('5')])
		war = WarGame.new(player1, player2)
		war.play_round
		assert_equal(4, war.player(0).number_of_cards)
		assert_equal(0, war.player(1).number_of_cards)
	end

	def test_player1_wins_longer_round_not_all_cards_played
		player1 = WarPlayer.new([PlayingCard.new('A'), PlayingCard.new('3')])
		player2 = WarPlayer.new([PlayingCard.new('6'), PlayingCard.new('8'), PlayingCard.new('3')])
		war = WarGame.new(player1, player2)
		war.play_round
		assert_equal(4, war.player(0).number_of_cards)
		assert_equal(1, war.player(1).number_of_cards)
	end

	def test_player1_wins_game
		player1 = WarPlayer.new([PlayingCard.new('4'), PlayingCard.new('A'), PlayingCard.new('3')])
		player2 = WarPlayer.new([PlayingCard.new('A'), PlayingCard.new('3')])
		war = WarGame.new(player1, player2)
		war.play_round
		assert_equal("Player 1", war.winner)
	end

	def test_player2_wins_game
		player1 = WarPlayer.new([PlayingCard.new('J'), PlayingCard.new('10')])
		player2 = WarPlayer.new([PlayingCard.new('4'), PlayingCard.new('J'), PlayingCard.new('10')])
		war = WarGame.new(player1, player2)
		war.play_round
		assert_equal("Player 2", war.winner)
	end

	def test_game_ends_in_tie
		player1 = WarPlayer.new([PlayingCard.new('J'), PlayingCard.new('10')])
		player2 = WarPlayer.new([PlayingCard.new('J'), PlayingCard.new('10')])
		war = WarGame.new(player1, player2)
		war.play_round
		assert_equal("Tie", war.winner)
	end

	def test_player1_wins_multi_round_game
		player1 = WarPlayer.new([PlayingCard.new('7'), PlayingCard.new('A')])
		player2 = WarPlayer.new([PlayingCard.new('2'), PlayingCard.new('7'), PlayingCard.new('3')])
		war = WarGame.new(player1, player2)
		war.play_game
		assert_equal("Player 1", war.winner)
	end

	def test_war_deals_cards_to_players
		war = WarGame.new(WarPlayer.new, WarPlayer.new)
		war.deal
		assert_equal(26, war.player(0).number_of_cards)
		assert_equal(26, war.player(1).number_of_cards)
	end

end
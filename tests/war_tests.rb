require 'minitest/autorun'
Dir[File.dirname(__FILE__) + '/../*.rb'].each { |file| require_relative "../#{file}"}

class TestWar < MiniTest::Unit::TestCase
	def setup
		@war = WarGame.new
		@deck = CardDeck.new
	end

	def test_player1_wins
		player1 = WarPlayer.new([PlayingCard.new('A')])
		player2 = WarPlayer.new([PlayingCard.new('2')])
		@war.play_round(player1, player2)
		assert_equal(2, player1.number_of_cards)
		assert_equal(0, player2.number_of_cards)
	end

	def test_player2_wins
		player1 = WarPlayer.new([PlayingCard.new('2')])
		player2 = WarPlayer.new([PlayingCard.new('3')])
		@war.play_round(player1, player2)
		assert_equal(0, player1.number_of_cards)
		assert_equal(2, player2.number_of_cards)
	end

	def test_player1_wins_longer_round
		player1 = WarPlayer.new([PlayingCard.new('A'), PlayingCard.new('5')])
		player2 = WarPlayer.new([PlayingCard.new('Q'), PlayingCard.new('5')])
		@war.play_round(player1, player2)
		assert_equal(4, player1.number_of_cards)
		assert_equal(0, player2.number_of_cards)
	end

	def test_player1_wins_longer_round_not_all_cards_played
		player1 = WarPlayer.new([PlayingCard.new('A'), PlayingCard.new('3')])
		player2 = WarPlayer.new([PlayingCard.new('6'), PlayingCard.new('8'), PlayingCard.new('3')])
		@war.play_round(player1, player2)
		assert_equal(4, player1.number_of_cards)
		assert_equal(1, player2.number_of_cards)
	end

	def test_player1_wins_game_when_player2_runs_out_of_cards
		player1 = WarPlayer.new([PlayingCard.new('4'), PlayingCard.new('A'), PlayingCard.new('3')])
		player2 = WarPlayer.new([PlayingCard.new('A'), PlayingCard.new('3')])
		@war.play_round(player1, player2)
		assert_equal("Player 1", @war.winner)
	end

	def test_player2_wins_game_when_player1_runs_out_of_cards
		player1 = WarPlayer.new([PlayingCard.new('J'), PlayingCard.new('10')])
		player2 = WarPlayer.new([PlayingCard.new('4'), PlayingCard.new('J'), PlayingCard.new('10')])
		@war.play_round(player1, player2)
		assert_equal("Player 2", @war.winner)
	end

	def test_game_ends_in_tie_when_both_players_run_out_of_cards
		player1 = WarPlayer.new([PlayingCard.new('J'), PlayingCard.new('10')])
		player2 = WarPlayer.new([PlayingCard.new('J'), PlayingCard.new('10')])
		@war.play_round(player1, player2)
		assert_equal("Tie", @war.winner)
	end

	def test_deck_has_cards
		assert_equal(true, @deck.has_cards?)

		hand = @deck.deal(26)
		assert_equal(26, hand.count)

		@deck.deal(26)
		assert_equal(false, @deck.has_cards?)
	end
end
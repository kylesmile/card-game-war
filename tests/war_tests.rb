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

	def test_deck_has_cards
		deck = CardDeck.new
		assert_equal(true, deck.has_cards?)

		hand = deck.deal(26)
		assert_equal(26, hand.count)
		assert_equal(12, hand[12].value)

		deck.deal(26)
		assert_equal(false, deck.has_cards?)
	end

	def test_deck_can_be_shuffled
		deck = CardDeck.new
		deck.shuffle
		card = deck.deal[0]
		assert(card.value != 12) # Yes, the deck could be shuffled and still have the top card be an ace
	end

end
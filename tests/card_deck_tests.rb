require 'minitest/autorun'
require_relative '../card_deck.rb'
require_relative '../playing_card.rb'

class TestCardDeck < MiniTest::Unit::TestCase
	def setup
		@deck = CardDeck.new
	end

	def test_deck_has_cards
		assert_equal(true, @deck.has_cards?)

		hand = @deck.deal(26)
		assert_equal(26, hand.count)

		@deck.deal(26)
		assert_equal(false, @deck.has_cards?)
	end

	def test_deal
		deck = CardDeck.new
		assert_equal(52, deck.number_of_cards)
		assert(deck.deal[0].is_a?(PlayingCard))
		assert_equal(51, deck.number_of_cards)
	end
end
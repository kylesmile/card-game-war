require_relative './war_player'
require_relative './card_deck'

class WarGame
	attr_reader :winner

	def initialize(*players)
		@players = players
	end

	def player(n)
		@players[n]
	end

	def deal
		deck = CardDeck.new
		deck.shuffle
		while deck.number_of_cards > 0
			@players.each do |player|
				player.take_cards(deck.deal)
			end
		end
	end

	def play_game
		while @winner.nil?
			play_round
		end
	end

	def play_round(cards=[], &block)
		played_cards = {}
		@players.each_with_index do |player, i|
			card = player.play_top_card
			cards.push(card)
			played_cards[i] = card
		end
		
		cards.compact!

		played_cards.delete_if { |key, value| value.nil? }

		played_sorted = played_cards.sort { |a,b| b[1].value <=> a[1].value}

		if (played_cards.count == 0)
			@winner = "Tie"
			block.call(nil, nil, @winner) if block_given?
		elsif (played_cards.count == 1)
			@winner = "Player #{played_cards.keys[0] + 1}"
			block.call(nil, nil, "#{@winner} wins!") if block_given?
		elsif (played_sorted[0][1].value == played_sorted[1][1].value)
			block.call(played_cards[0], played_cards[1], "Tied cards!") if block_given?
			play_round(cards, &block)
		else
			cards.shuffle!
			player(played_sorted[0][0]).take_cards(cards)
			message = "Player #{played_sorted[0][0] + 1} wins #{cards.count} cards!"
			block.call(played_cards[0], played_cards[1], message) if block_given?
		end
	end
end
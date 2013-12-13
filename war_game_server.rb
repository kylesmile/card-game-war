require 'socket'
require_relative './war_game'

class WarGameServer
	CONTROL_SEQUENCE = 'END'
	attr_reader :game

	def initialize(port=51528)
		@server = TCPServer.new(port)
		@clients = []
	end

	def accept_new_client
		client = @server.accept
		@clients << client
		client.puts "Welcome, Player #{@clients.count}!#{CONTROL_SEQUENCE}"

		if @clients.count == 2
			@game = WarGame.new(WarPlayer.new, WarPlayer.new)
			@game.deal
		end
	end

	def take_commands
		player1_command = @clients[0].gets
		player2_command = @clients[1].gets
		play_round
	end

	def stop
		@server.close
	end

	def play_round
		@game.play_round do |card1, card2, result|
			@clients.each do |client|
				client.puts(pretty_round_result(card1, card2, result))
			end
		end
	end

	def pretty_round_result(card1, card2, result)
		message = ""
		message << "Player 1: #{card1.to_s}\nPlayer 2: #{card2.to_s}\n" if card1 && card2
		message << "#{result}"
		message << CONTROL_SEQUENCE if message =~ /wins/
	end
end
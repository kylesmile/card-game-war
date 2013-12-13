require 'minitest/autorun'
require_relative '../war_game_server'

class WarGame # Cheat to make testing feasible
	def rig_cards(player1_cards, player2_cards)
		@players[0].set_cards(player1_cards)
		@players[1].set_cards(player2_cards)
	end
end

class WarPlayer
	def set_cards(cards)
		@cards = cards
	end
end

class FakeClient
	attr_reader :socket
	attr_reader :output

	def initialize(port=51528)
		@socket = TCPSocket.new('localhost', port)
	end

	def provide_input(text)
		@socket.puts(text)
	end

	def capture_output
		sleep(0.1)
		@output = @socket.read_nonblock(1000)
		@output = @output.split("END").first
	rescue IO::WaitReadable
		@output = ""
	end

	def discard_output
		capture_output
		@output = ""
	end
end

class TestWarSocketServer < MiniTest::Unit::TestCase

	def setup
		@server = WarGameServer.new
	end

	def teardown
		@server.stop
	end

	def test_server_starts
		client = FakeClient.new
		pass('Connection in place')
		client.socket.close
	rescue Errno::ECONNREFUSED
		flunk('Connection refused')
	end

	def test_server_starts_game
		client1 = FakeClient.new
		@server.accept_new_client
		client1.capture_output
		assert_equal("Welcome, Player 1!", client1.output)
		assert_nil(@server.game, 'Game created too early')
		client2 = FakeClient.new
		@server.accept_new_client
		client2.capture_output
		assert_equal("Welcome, Player 2!", client2.output)
		refute_nil(@server.game, 'No game created')
	end

	def test_play_round
		client1 = FakeClient.new
		@server.accept_new_client
		client2 = FakeClient.new
		@server.accept_new_client
		@server.play_round
		client1.capture_output
		client2.capture_output
		refute(client1.output.empty?, "client1 has no output")
		refute(client2.output.empty?, "client2 has no output")
	end

	def test_round_output
		client1 = FakeClient.new
		@server.accept_new_client
		client2 = FakeClient.new
		@server.accept_new_client
		client1.discard_output
		client2.discard_output
		@server.game.rig_cards([PlayingCard.new('A', 'S')], [PlayingCard.new('J', 'D')])
		@server.play_round
		expected_output = <<-EOM
Player 1: Ace of Spades
Player 2: Jack of Diamonds
Player 1 wins 2 cards!
EOM
		client1.capture_output
		assert_equal(expected_output.chomp, client1.output)
	end

	def test_server_takes_commands
		client1 = FakeClient.new
		@server.accept_new_client
		client2 = FakeClient.new
		@server.accept_new_client
		client1.discard_output
		client2.discard_output
		client1.provide_input('')
		client2.provide_input('')
		@server.take_commands
		client1.capture_output
		refute(client1.output.empty?, 'Server did not take commands')
	end
end
require 'minitest/autorun'
require_relative '../war_game_client'
require_relative '../war_game_server'

class TestWarSocketClient < MiniTest::Unit::TestCase

	def setup
		@server = WarGameServer.new
	end

	def teardown
		@server.stop
	end

	def test_client_connects_to_server
		client = WarGameClient.new('localhost')
		begin
			@server.accept_new_client
			pass('Client connected')
		rescue Errno::EAGAIN
			flunk('Client did not connect')
		end
	end

	def test_client_sends_user_input_to_server
		client1 = WarGameClient.new('localhost')
		@server.accept_new_client
		client2 = WarGameClient.new('localhost')
		@server.accept_new_client
		client1.get_server_input
		client1.send_message('')
		client2.send_message('')
		@server.take_commands
		assert_match(/wins/, client1.get_server_input)
	end

	def test_client_displays_server_responses
		client = WarGameClient.new('localhost')
		@server.accept_new_client
		assert_equal("Welcome, Player 1!", client.get_server_input)
	end
end
require 'cucumber/rspec/doubles'

require_relative 'helpers/room_list_generator'
require_relative '../../src/mystery_forest'

Before do
  @test_output = double("Output")
  @test_input = double("Input")
end

Given(/^that the game has started$/) do
  exit_message = "Thanks for playing!"
  locations = []
  locations << Location.new(Point.new(0, 0), Room.new("You are in the first room 0,0",[],[]))

  @room_list = RoomList.new(locations)
  @environment = Environment.new(@room_list)
  @environment.set_greeting('greeting')
  allow(@test_output).to receive(:clear)
  allow(@test_output).to receive(:send_output)
end

When(/^I issue a command "([^"]*)"$/) do |command|
  allow(@test_input).to receive(:get_input){command}
end

Then(/^the game will respond with a message "([^"]*)"$/) do |expected_message|
  @game = MysteryForest.new(@test_input, @test_output,@environment)
  @game.run
end

Given(/^that I have a game setup with a greeting "([^"]*)"$/) do |greeting|
  locations = []
  locations << Location.new(Point.new(0, 0), Room.new("You are in the first room 0,0",[],[]))

  @room_list = RoomList.new(locations)
  @environment = Environment.new(@room_list)
  @greeting_message = greeting
  @environment.set_greeting(@greeting_message)
  allow(@test_output).to receive(:clear)
  allow(@test_output).to receive(:send_output)
  allow(@test_input).to receive(:get_input){'quit'}
  expect(@test_output).to receive(:send_output).with(@greeting_message)
end

When(/^the game begins$/) do
  @game = MysteryForest.new(@test_input, @test_output, @environment)
end

Then(/^the welcome message must be displayed$/) do
  @game.run
end

Given(/^that I have some rooms$/) do |rooms_table|
  room_list_generator = RoomListGenerator.new
  rooms_table.hashes.each do |row|
    puts row["location x"]
  end
end

When(/^I issue no commands$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the game will respond with$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

def create_room(location_x, location_y, description)

end


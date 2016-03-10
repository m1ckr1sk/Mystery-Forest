require 'cucumber/rspec/doubles'

require_relative 'helpers/location_list_generator'
require_relative '../../src/mystery_forest'

Before do
  @test_output = double("Output")
  @test_input = double("Input")
end

After do
  
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
  location_list = LocationListGenerator.generate_location_list(rooms_table.hashes)
  @room_list = RoomList.new(location_list)
  @environment = Environment.new(@room_list)
  @environment.set_greeting('welcome')
  allow(@test_output).to receive(:clear)
  allow(@test_output).to receive(:send_output)
end

When(/^I issue no commands$/) do
  allow(@test_input).to receive(:get_input){'quit'}
end

Then(/^the game will respond with$/) do |expectations|
  expectations.hashes.each do |row|
    expect(@test_output).to receive(:send_output).with(row["output"])  
  end
  
  @game = MysteryForest.new(@test_input, @test_output, @environment)
  @game.run
end


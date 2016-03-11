require 'cucumber/rspec/doubles'

require_relative 'helpers/location_list_generator'
require_relative 'helpers/command_injector'
require_relative '../../src/mystery_forest'

Before do
  @test_output = OutputLogger.new
end

Given(/^that I have a game setup with a greeting "([^"]*)"$/) do |greeting|
  locations = []
  locations << Location.new(Point.new(0, 0), Room.new("You are in the first room 0,0",[],[]))

  @room_list = RoomList.new(locations)
  @environment = Environment.new(@room_list)
  @greeting_message = greeting
  @environment.set_greeting(@greeting_message)
end

Given(/^that the game has started$/) do
  exit_message = "Thanks for playing!"
  locations = []
  locations << Location.new(Point.new(0, 0), Room.new("You are in the first room 0,0",[],[]))

  @room_list = RoomList.new(locations)
  @environment = Environment.new(@room_list)
  @environment.set_greeting('greeting')
end

Given(/^that I have some rooms$/) do |rooms_table|
  location_list = LocationListGenerator.generate_location_list(rooms_table.hashes)
  @room_list = RoomList.new(location_list)
  @environment = Environment.new(@room_list)
  @environment.set_greeting('welcome')
end

When(/^I issue no commands$/) do
  @test_input = CommandInjector.new([])
  @game = MysteryForest.new(@test_input, @test_output, @environment)
  @game.run
end

When(/^I issue a command "([^"]*)"$/) do |command|
  commands = []
  commands << command
  @test_input = CommandInjector.new(commands)
  @game = MysteryForest.new(@test_input, @test_output,@environment)
  @game.run
end

When(/^I issue the commands$/) do |commands_list|
  commands = []
  commands_list.hashes.each do |command|
    commands << command["command"]
  end
  @test_input = CommandInjector.new(commands)
  @game = MysteryForest.new(@test_input, @test_output,@environment)
  @game.run
end

Then(/^the game will respond with$/) do |expectations|
  expectations.hashes.each do |row|
    expect(@test_output.output_logged).to include(row["output"].gsub("'", ""))
  end
end

Then(/^the game will respond with exactly$/) do |expectations|
  expected_commands = []
  expectations.hashes.each do |row|
    expected_commands << row["output"].gsub("'", "")
  end
  expect(@test_output.output_logged).to match_array(expected_commands)
end

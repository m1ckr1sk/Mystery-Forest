require 'cucumber/rspec/doubles'

require_relative 'helpers/location_list_generator'
require_relative 'helpers/command_injector'
require_relative '../../src/mystery_forest'

Before do
  @test_output = OutputLogger.new
end

Given(/^that I have a game setup with a greeting "([^"]*)"$/) do |greeting|
  @locations_hash = create_single_room
  @greeting = greeting
end

Given(/^that the game has started$/) do
  @locations_hash = create_single_room
  @greeting = 'welcome'
end

Given(/^that I have some rooms$/) do |rooms_table|
  @locations_hash = rooms_table.hashes
end

Given(/^that I have a welcome message "([^"]*)"$/) do |greeting|
  @greeting = greeting
end

Given(/^I have some items in the rooms$/) do |items_table|
  add_items_to_locations(items_table.hashes)
end

Given(/^I have some people in the rooms$/) do |people_table|
  add_people_to_locations(people_table.hashes)
end

When(/^I issue no commands$/) do
  @game = MysteryForest.new(CommandInjector.new([]), @test_output, create_environment)
  @game.run
end

When(/^I issue a command "([^"]*)"$/) do |command|
  commands = []
  commands << command
  @game = MysteryForest.new(CommandInjector.new(commands), @test_output, create_environment)
  @game.run
end

When(/^I issue the commands$/) do |commands_list|
  commands = []
  commands_list.hashes.each do |command|
    commands << command["command"]
  end
  @game = MysteryForest.new(CommandInjector.new(commands), @test_output, create_environment)
  @game.run
end

Then(/^the game will respond with$/) do |expectations|
  expectations.hashes.each do |row|
    expected_text = row["output"].chop.reverse.chop.reverse
    STDOUT.puts("EXPECTED:#{expected_text}")
    expect(@test_output.output_logged).to include(expected_text)
  end
end

Then(/^the game will respond with exactly$/) do |expectations|
  expected_commands = []
  expectations.hashes.each do |row|
    
  if row["output"][0] == "'" then expected_text = row["output"].reverse.chop.reverse else expected_text = row["output"] end
  if expected_text[-1] == "'" then expected_text = expected_text.chop end
    STDOUT.puts("EXPECTED:#{expected_text}")
    expected_commands << expected_text
  end
  expect(@test_output.output_logged).to match_array(expected_commands)
end

def create_environment
  room_list = RoomList.new(LocationListGenerator.generate_location_list(@locations_hash))
  environment = Environment.new(room_list)
  environment.set_greeting(@greeting)
  return environment
end

def create_single_room
  return [{'id' => '1', 'location x' => '0','location y' => '0','description' => 'You are in the first room 0,0'}]
end

Given(/^I have some script actions$/) do |table|
  add_script_actions_to_person(table.hashes)
end

Given(/^I have some script responses$/) do |table|
  add_script_responses_to_person(table.hashes)
end

def add_items_to_locations(items_hash)
  items_hash.each do |item_row|
    if room = @locations_hash.find { |k,v| k.to_s[item_row['room']] }
      if room['items'].nil?
        room['items'] = [item_row]
      else
        room['items'] << item_row
      end
    end
  end
end

def add_people_to_locations(people_hash)
  people_hash.each do |people_row|
    if room = @locations_hash.find { |k,v| k.to_s[people_row['room']] }
      if room['people'].nil?
        room['people'] = [people_row]
      else
        room['people'] << people_row
      end
    end
  end
end

def add_script_actions_to_person(scripts_action_hash)
  scripts_action_hash.each do |script_action_row|
    person = find_person(script_action_row['person'])
    if !person.nil?
      if person['script_actions'].nil?
        person['script_actions'] = [script_action_row]
      else
        person['script_actions'] << script_action_row
      end
    end
  end
end

def find_person(person_id)
  person_found = nil
  @locations_hash.each do |location|
    STDOUT.puts "LOCATION:#{location}"
    if location.include?('people')
      location['people'].each do | person|
        STDOUT.puts "FINDING PERSON:#{person['person']} with #{person_id}"
        if person['person'] == person_id
          STDOUT.puts "FOUND PERSON:#{person}"
          person_found = person
        end
      end
    end
  end
  return person_found
end

def add_script_responses_to_person(scripts_response_hash)
  scripts_response_hash.each do |script_response_row|
    person = find_person(script_response_row['person'])
    if !person.nil?
      if person['script_responses'].nil?
        person['script_responses'] = [script_response_row]
      else
        person['script_responses'] << script_response_row
      end
    end
  end
end

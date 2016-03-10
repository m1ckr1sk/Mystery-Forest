require_relative '../../src/mystery_forest'

Given(/^that the game has started$/) do
  exit_message = "Thanks for playing!"
  test_output = double("Output")
  test_input = double("Input")

  allow(test_output).to receive(:clear)
  allow(test_output).to receive(:send_output)
  allow(test_input).to receive(:get_input){"quit"}
  expect(test_output).to receive(:send_output).with(exit_message)

  
end

When(/^I issue a command "([^"]*)"$/) do |command|
  game = MysteryForest.new(test_input, test_output)
  
end

Then(/^the game will respond with a message "([^"]*)"$/) do |arg1|
  game.run
end

Given(/^that I have some rooms$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I issue no commands$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the game will respond with$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end


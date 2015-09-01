require_relative 'wrapped_screen_output'
require_relative 'stdin_input'
require_relative 'mystery_forest'

$debug = ARGV.include?("debug")
wrapped_screen_output = WrappedScreenOutput.new
stdin_input = StdInInput.new
game = MysteryForest.new(stdin_input, wrapped_screen_output)

game.run
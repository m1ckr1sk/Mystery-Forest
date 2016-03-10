require_relative 'wrapped_screen_output'
require_relative 'stdin_input'
require_relative 'mystery_forest'

$debug = ARGV.include?("debug")
wrapped_screen_output = WrappedScreenOutput.new
stdin_input = StdInInput.new
room_list = new RoomList.new
environment = Environment.new(room_list)
environment.set_greeting("You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are.")
player = Player.new(environment)
game = MysteryForest.new(stdin_input, wrapped_screen_output,player)

game.run
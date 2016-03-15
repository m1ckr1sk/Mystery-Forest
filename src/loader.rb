require_relative 'wrapped_screen_output'
require_relative 'stdin_input'
require_relative 'mystery_forest'

$debug = ARGV.include?("debug")
wrapped_screen_output = WrappedScreenOutput.new
stdin_input = StdInInput.new
locations = []
locations << Location.new(Point.new(0, 0), Room.new("The mist slowly swirls around you and curls around the trees, lazily forming silver streams.",[],[]))
locations << Location.new(Point.new(0, 1), Room.new("You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It's almost more foreboding to have tall shadows looming over you than just trees surrounded by mist.", [
  Item.new("Iron Dagger", ["iron dagger", "dagger"], "It is a short, metal dagger. The blade is flat, but sharp. The handle is plain and unadorned of any decoration except for a two circles.")
]))

locations << Location.new(Point.new(1, 0), Room.new("The mist is as thick as ever, a dense, white sheet."))
locations << Location.new(Point.new(1, 1), Room.new( "There must be a clearing in the trees here, you can see a halo where the sun must be shining from above."))
locations << Location.new(Point.new(2, 1), Room.new("You think you can see a faint path beneath the mist."))
  
actions = {
            greet: ["'Hello,' the man smiles at you.", [:ask_purpose]],
            purpose: ["'I am here to guide you.'", [:bye]],
            bye: ["'I will see you later.'", []]
          }
          
responses = {
            ask_purpose: ["'What are you doing here?'", :purpose],
            bye: ["'Good bye.'", :bye]
          }
script_actions = ScriptActions.new(actions)
script_responses = ScriptResponses.new(responses)
script = Script.new(script_actions,script_responses)
locations << Location.new(Point.new(3, 1), Room.new("The mist drapes over yourself and the trees, creating a heavy blanket.",[],[
  Person.new("Malich", "An old man, face coated in a fine dust of gray facial hair. He is wearing a dull blue robe and staring at you, waiting for you to do something.", script)
]))
locations << Location.new(Point.new(4, 0), Room.new("You can see tall shadows surrounding you. Not trees. They feel cold and hard like stone."))
locations << Location.new(Point.new(4, 1), Room.new("You can feel the firm stone beneath your feet."))
locations << Location.new(Point.new(4, 2), Room.new("The mist has thinned, you see a hole in the ground."))
locations << Location.new(Point.new(5, 1), Room.new("Now the mist has settled, twirling around your ankles. Even though you can see, all you see is inky black. You don't see any trees."))

room_list = RoomList.new(locations)
environment = Environment.new(room_list)
environment.set_greeting("You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are.")
player = Player.new(environment)
game = MysteryForest.new(stdin_input, wrapped_screen_output,environment)

game.run
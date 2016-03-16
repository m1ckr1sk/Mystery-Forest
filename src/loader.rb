require_relative 'wrapped_screen_output'
require_relative 'stdin_input'
require_relative 'mystery_forest'
require_relative 'location_list_generator'

wrapped_screen_output = WrappedScreenOutput.new
stdin_input = StdInInput.new

locations_json = '[{"id":"1","location x":"0","location y":"0","description":"The mist slowly swirls around you and curls around the trees, lazily forming silver streams."},{"id":"2","location x":"0","location y":"1","description":"You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It''s almost more foreboding to have tall shadows looming over you than just trees surrounded by mist.","items":[{"room":"2","name":"Iron Dagger","description":"It is a short, metal dagger. The blade is flat, but sharp. The handle is plain and unadorned of any decoration except for a two circles.","possibles":"dagger"}]},{"id":"3","location x":"1","location y":"0","description":"The mist is as thick as ever, a dense, white sheet."},{"id":"4","location x":"1","location y":"1","description":"There must be a clearing in the trees here, you can see a halo where the sun must be shining from above."},{"id":"5","location x":"2","location y":"1","description":"You think you can see a faint path beneath the mist."},{"id":"6","location x":"3","location y":"1","description":"The mist drapes over yourself and the trees, creating a heavy blanket.","people":[{"room":"6","name":"Malich","description":"An old man, face coated in a fine dust of gray facial hair. He is wearing a dull blue robe and staring at you, waiting for you to do something.","person":"1","script_actions":[{"person":"1","action":"greet","text":"''Hello,'' the man smiles at you.","response":"ask_purpose"},{"person":"1","action":"purpose","text":"''I am here to guide you.''","response":"bye"},{"person":"1","action":"bye","text":"''I will see you later.''","response":""}],"script_responses":[{"person":"1","response":"ask_purpose","text":"''What are you doing here?''","next actions":"purpose"},{"person":"1","response":"bye","text":"''Good bye.''","next actions":"bye"}]}]},{"id":"7","location x":"4","location y":"0","description":"You can see tall shadows surrounding you. Not trees. They feel cold and hard like stone."},{"id":"8","location x":"4","location y":"1","description":"You can feel the firm stone beneath your feet."},{"id":"9","location x":"4","location y":"2","description":"The mist has thinned, you see a hole in the ground."},{"id":"10","location x":"5","location y":"1","description":"Now the mist has settled, twirling around your ankles. Even though you can see, all you see is inky black. You don''t see any trees."}]'
triggers_json = '{"trip_root":{"triggered":0,"location_x":2,"location_y":1,"trigger_output":"You trip over a root, grabbing out to a tree to keep your balance."}}'
welcome_greeting = "You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are."

room_list = RoomList.new(LocationListGenerator.generate_location_list(JSON.parse(locations_json)))
triggers = JSON.parse(triggers_json)
  
environment = Environment.new(room_list,triggers)
environment.set_greeting(welcome_greeting)
player = Player.new(environment)
game = MysteryForest.new(stdin_input, wrapped_screen_output,environment)

game.run
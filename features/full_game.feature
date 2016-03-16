Feature: Full game

Scenario: The full original game as a test
Given that I have a welcome message "You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are."
And that I have some rooms
|id | location x | location y | description	 																																																								  |
|1  | 0          | 0	      | The mist slowly swirls around you and curls around the trees, lazily forming silver streams.                             																													  |
|2  | 0          | 1	      | You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It's almost more foreboding to have tall shadows looming over you than just trees surrounded by mist.    |
|3  | 1          | 0	      | The mist is as thick as ever, a dense, white sheet.    																																														  |
|4  | 1          | 1	      | There must be a clearing in the trees here, you can see a halo where the sun must be shining from above.    																																  |
|5  | 2          | 1	      | You think you can see a faint path beneath the mist.   																																														  |
|6  | 3          | 1	      | The mist drapes over yourself and the trees, creating a heavy blanket.   																																									  |
|7  | 4          | 0	      | You can see tall shadows surrounding you. Not trees. They feel cold and hard like stone.   																																					  |
|8  | 4          | 1	      | You can feel the firm stone beneath your feet.    																																															  |
|9  | 4          | 2	      | The mist has thinned, you see a hole in the ground.    																																														  |
|10 | 5          | 1	      | Now the mist has settled, twirling around your ankles. Even though you can see, all you see is inky black. You don't see any trees.    																										  |
And I have some items in the rooms
| room | name       | description       																														 | possibles    |
|	2  | Iron Dagger| It is a short, metal dagger. The blade is flat, but sharp. The handle is plain and unadorned of any decoration except for a two circles.   | dagger     	|
And I have some people in the rooms
| room | name       | description       																																 | person         |
|	6  | Malich     | An old man, face coated in a fine dust of gray facial hair. He is wearing a dull blue robe and staring at you, waiting for you to do something.    | 1              |
And I have some script actions
| person | action   | text 								| response 			|
| 1      | greet    | 'Hello,' the man smiles at you.   | ask_purpose	    |
| 1      | purpose  | 'I am here to guide you.'   	    | bye	            |
| 1      | bye      | 'I will see you later.'   	    |  					|
And I have some script responses
| person | response 	 | text 						| next actions 		|
| 1      | ask_purpose   | 'What are you doing here?'   | purpose			|
| 1      | bye   		 | 'Good bye.'   				| bye				|
And that I have some triggers
|room| name		 | location x | location y | trigger output	 													|	
|1 	 | trip_root | 2          | 1		   | You trip over a root, grabbing out to a tree to keep your balance. |
When I issue the commands
|command		    |
|n					|
|take dagger		|
|i					|
|e					|
|e					|
|e					|
|talk malich		|
|1					|
|1					|
|e					|
|q					|
Then the game will respond with exactly
|output						|
| clear |
| You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are. |
| '' |
| The mist slowly swirls around you and curls around the trees, lazily forming silver streams. |
| You can go: north, east |
| '> ' |
| clear |
| '' |
| You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It's almost more foreboding to have tall shadows looming over you than just trees surrounded by mist. |
| You can go: south, east |
| You see: Iron Dagger |
| '> ' |
| clear |
| You take the iron dagger. |
| '' |
| You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It's almost more foreboding to have tall shadows looming over you than just trees surrounded by mist. |
| You can go: south, east |
| '> ' |
| clear |
| You are holding: iron dagger |
| '' |
| You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It's almost more foreboding to have tall shadows looming over you than just trees surrounded by mist. |
| You can go: south, east |
| '> ' |
| clear |
| '' |
| There must be a clearing in the trees here, you can see a halo where the sun must be shining from above. |
| You can go: south, west, east |
| '> ' |
| clear |
| You trip over a root, grabbing out to a tree to keep your balance. |
| '' |
| You think you can see a faint path beneath the mist. |
| You can go: west, east |
| '> ' |
| clear |
| '' |
| The mist drapes over yourself and the trees, creating a heavy blanket. |
| You see: Malich |
| You can go: west, east |
| '> ' |
| clear |
| ''Hello,' the man smiles at you.' |
| Your response: |
| 1. 'What are you doing here?'' |
| ': ' |
| clear |
| ''I am here to guide you.'' |
| Your response: |
| 1. 'Good bye.'' |
| ': ' |
| clear |
| '' |
| The mist drapes over yourself and the trees, creating a heavy blanket. |
| You see: Malich |
| You can go: west, east |
| '> ' |
| clear |
| '' |
| You can feel the firm stone beneath your feet. |
| You can go: south, west, north, east |
| '> ' |
| clear |
| Thanks for playing! |

Feature: Non playable characters

Scenario: Should display people in room when a room is entered
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some people in the rooms
| room | name       | description       				| script         |
|	1  | george     | An old man with a crooked nose    |                |
When I issue no commands
Then the game will respond with exactly
|output						|
|clear						|
|welcome					|
|							|
|entrance room				|
|You can go: north 			|	 
|You see: george         	|
|'> ' 						|
|clear						|
|Thanks for playing!		|

Scenario: Should describe people in room when looked at
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some people in the rooms
| room | name       | description       				| person         |
| 1    | george     | An old man with a crooked nose    | 1              |
When I issue the commands
|command		    |
|look at george		|
Then the game will respond with exactly
|output						|
|clear						|
|welcome					|
|							|
|entrance room				|
|You can go: north 			|	 
|You see: george         	|
|'> ' 						|
| clear                     |
| An old man with a crooked nose |
|                           |
| entrance room             |
| You see: george           |
| You can go: north         |
| '> '                      |
|clear						|
|Thanks for playing!		|

Scenario: Should enable conversations
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some people in the rooms
| room | name       | description       				| person         |
|	1  | george     | An old man with a crooked nose    | 1              |
And I have some script actions
| person | action | text 		| response 			|
| 1      | greet  | Hi   		| greet_response	|
| 1      | bye    | Goodbye   	|  					|
And I have some script responses
| person | response 		| text 			| next actions 		|
| 1      | greet_response   | Hello there   | bye				|
When I issue the commands
|command		    |
|talk to george		|
|1					|
Then the game will respond with exactly
|output						|
| clear                     |
| welcome                   |
| ''                        |
| entrance room             |
| You see: george           |
| You can go: north         |
| '> '                      |
| clear                     |
| Hi                        |
| Your response:            |
| 1. Hello there            |
| ': '                      |
| clear                     |
| Goodbye					|
| ''                        |
| entrance room             |
| You see: george           |
| You can go: north         |
| '> '                      |
| clear                     |
| Thanks for playing!       |

Scenario: Should enable conversations with multiple people
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some people in the rooms
| room | name       | description       				| person         |
|	1  | george     | An old man with a crooked nose    | 1              |
|	2  | darcey     | An old lady with a wicked smile   | 2              |
And I have some script actions
| person | action 			| text 												| response 			|
| 1      | greet  			| Hi   												| greet_response	|
| 1      | bye    			| Goodbye   										|					|
| 2      | greet  			| Ha ha ha, Do you like riddles? 					| greet_response	|
| 2      | riddle 			| What is black and white and red all over?   	    | riddle_response_penguin, riddle_response_newspaper  |
| 2      | riddle_correct   | Oh, damn you got it right.   						| goodbye_response 					|
| 2      | riddle_incorrect | Nope.   											| goodbye_response 					|
| 2      | bye    			| Whatever.   										|  					|
And I have some script responses
| person | response 				 | text 	          | next actions 		|
| 1      | greet_response   		 | Hello there        | bye				|
| 2      | greet_response   		 | Yep   	          | riddle				|
| 2      | riddle_response_penguin   | Penguin            | riddle_incorrect	|
| 2      | riddle_response_newspaper | Newspaper   		  | riddle_correct		|
| 2      | goodbye_response			 | This is ridiculous | bye		|
When I issue the commands
|command		    |
|talk to george		|
|1					|
|north					|
|talk to darcey					|
|1					|
|2					|
|1					|
Then the game will respond with exactly
|output						|
| clear                     |
| welcome                   |
| ''                        |
| entrance room             |
| You see: george           |
| You can go: north         |
| '> '                      |
| clear                     |
| Hi                        |
| Your response:            |
| 1. Hello there            |
| ': '                      |
| clear 					|
| Goodbye 					|
| ''						|
| entrance room 			|
| You see: george 			|
| You can go: north 		|
| '> '						|
| clear 					|
| '' 						|
| north room 				|
| You see: darcey 			|
| You can go: south 		|
| '> '  					|
| clear 					|
| Ha ha ha, Do you like riddles? |
| Your response: 			|
| 1. Yep 					|
| ': '  					|
| clear 					|
| What is black and white and red all over? |
| Your response: 			|
| 1. Penguin 				|
| 2. Newspaper 				|
| ': ' 						|
| clear 					|
| Oh, damn you got it right. |
| Your response: 			|
| 1. This is ridiculous 	|
| ': ' 						|
| clear 					|
| Whatever. 				|
| '' 						|
| north room 				|
| You see: darcey 			|
| You can go: south 		|
| '> ' 						|
| clear 					|
| Thanks for playing! 		|


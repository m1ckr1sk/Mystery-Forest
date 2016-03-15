Feature: Non playable characters

Scenario: Should display people in room when a room is entered
Given that I have some rooms
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
Given that I have some rooms
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
Given that I have some rooms
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
| ''                        |
| entrance room             |
| You see: george           |
| You can go: north         |
| '> '                      |
| clear                     |
| Thanks for playing!       |

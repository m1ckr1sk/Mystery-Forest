Feature: Item management

Scenario: Should display inventory when prompted
Given that I have a welcome message "welcome"
And that I have some rooms
| location x| location y| description	|
| 0         | 0			|entrance room  |
When I issue the commands
|command		|
|Inventory		|
Then the game will respond with exactly
|output					|
|clear					|
|welcome				|
|						|
|entrance room 			|
|'You can go: '			|
| '> ' 					|
|clear					|
|'You are holding: '	|
|						|
|entrance room			|
|'You can go: '			|
| '> ' 					|
|clear					|
|Thanks for playing!	|

Scenario: Should display items in room when a room is entered
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some items in the rooms
| room | name       | description       | possibles      |
|	1  | chicken    | Its eating corn   | chick,bird     |
|	1  | potato     | Ripe for chipping | spud,pot       |
When I issue no commands
Then the game will respond with exactly
|output						|
|clear						|
|welcome					|
|							|
|entrance room				|
|You can go: north 			|	 
|You see: chicken, potato	|
|'> ' 						|
|clear						|
|Thanks for playing!		|

Scenario: Should describe items in room when an item is looked at
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some items in the rooms
| room | name       | description       | possibles      |
|	1  | chicken    | Its eating corn   | chick,bird     |
|	1  | potato     | Ripe for chipping | spud,pot       |
When I issue the commands
|command		    |
|look at potato		|
Then the game will respond with exactly
|output						|
|clear						|
|welcome					|
|							|
|entrance room				|
|You can go: north 			|	 
|You see: chicken, potato	|
|'> ' 						|
| clear 				    |
| Ripe for chipping         |
|                           |
| entrance room             |
| You can go: north         |
| You see: chicken, potato  |
| '> '                      |
|clear						|
|Thanks for playing!		|

Scenario: Should describe items in room when an item is looked at another possible name
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some items in the rooms
| room | name       | description       | possibles      |
|	1  | chicken    | Its eating corn   | chick,bird     |
|	1  | potato     | Ripe for chipping | spud,pot       |
When I issue the commands
|command		    |
|look at spud		|
Then the game will respond with exactly
|output						|
|clear						|
|welcome					|
|							|
|entrance room				|
|You can go: north 			|	 
|You see: chicken, potato	|
|'> ' 						|
| clear 				    |
| Ripe for chipping         |
|                           |
| entrance room             |
| You can go: north         |
| You see: chicken, potato  |
| '> '                      |
|clear						|
|Thanks for playing!		|

Scenario: Should describe multiple word named items in room when an item is looked at
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some items in the rooms
| room | name       | description              | possibles            |
|	1  | hungry chicken    | Its eating corn   | chick,bird     	  |
|	1  | big potato        | Ripe for chipping | spud,pot,potato      |
When I issue the commands
|command		        |
|look at big potato		|
Then the game will respond with exactly
|output						|
|clear						|
|welcome					|
|							|
|entrance room				|
|You can go: north 			|	 
|You see: hungry chicken, big potato	|
|'> ' 						|
| clear 				    |
| Ripe for chipping         |
|                           |
| entrance room             |
| You can go: north         |
| You see: hungry chicken, big potato  |
| '> '                      |
|clear						|
|Thanks for playing!		|

Scenario: Should allow players to add items in the room to inventory
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
And I have some items in the rooms
| room | name       | description       | possibles      |
|	1  | chicken    | Its eating corn   | chick,bird     |
|	1  | potato     | Ripe for chipping | spud,pot       |
When I issue the commands
|command		    |
|Take potato		|
|Inventory	    	|
Then the game will respond with exactly
|output                  |
|clear                   |
|welcome                 |
|                        |
|entrance room		     |
|'You can go: '			 | 
|You see: chicken, potato|
| '> '                   | 
|clear                   |
|You take the potato.    |
|						 |
|entrance room		     |
|'You can go: '			 | 
|You see: chicken 		 |
| '> '                   |
|clear					 |
|You are holding: potato |
| 						 |
|entrance room		     |
|'You can go: '			 | 
|You see: chicken 		 |
| '> '                   |
|clear					 |
|Thanks for playing!     |

Scenario: Should allow players to drop items into the room from inventory
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
And I have some items in the rooms
| room | name       | description       | possibles      |
|	1  | chicken    | Its eating corn   | chick,bird     |
|	1  | potato     | Ripe for chipping | spud,pot       |
When I issue the commands
|command		    |
|Take potato		|
|Inventory	    	|
| Drop potato		|
|Inventory			|
Then the game will respond with exactly
|output                    |
| clear                    |
| welcome                  |
|                          |
| entrance room            |
| 'You can go: '           |
| You see: chicken, potato |
| '> '                     |
| clear 		           |
| You take the potato.     |
|                          |
| entrance room            |
| 'You can go: '           |
| You see: chicken         |
| '> '                     |
| clear                    |
| You are holding: potato  |
|                          |
| entrance room            |
| 'You can go: '           |
| You see: chicken         |
| '> '                     |
| clear                    |
| You drop the potato.     |
|                          |
| entrance room            |
| 'You can go: '           |
| You see: chicken, potato |
| '> '                     |  
| clear                    |
| 'You are holding: '      |
|                          |
| entrance room            |
| 'You can go: '           |
| You see: chicken, potato |
| '> '                     |
| clear                    |
| Thanks for playing!      |

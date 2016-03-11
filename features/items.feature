Feature: Item management

Scenario: Should display inventory when prompted
Given that I have some rooms
| location x| location y| description	|
| 0         | 0			|entrance room|
| 0         | 1			|north room|
When I issue the commands
|command|
|Inventory|
Then the game will respond with exactly
|output|
|clear|
|welcome|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
|'You are holding: '|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
|Thanks for playing!|

Scenario: Should display items in room when a room is entered
Given that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And I have some items in the rooms
| room | name       | description       | possibles      |
|	1  | chicken    | Its eating corn   | chick,bird    |
|	1  | potato     | Ripe for chipping | spud,pot     |
When I issue no commands
Then the game will respond with exactly
|output|
|clear|
|welcome|
||
|entrance room|
|You can go: north|
|You see: chicken, potato|
| '> ' |
|clear|
|Thanks for playing!|

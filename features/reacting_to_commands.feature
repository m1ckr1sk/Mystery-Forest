Feature: Command consumption

Scenario: Quitting the game should show a farewell message

Given that the game has started
When I issue a command "quit"
Then the game will respond with a message "Thanks for playing!"

Scenario: starting the game should output a greeting
Given that I have a game setup with a greeting "Welcome to the game" 
When the game begins
Then the welcome message must be displayed

Scenario: starting the game at first room
Given that I have some rooms
| location x| location y| description	|
| 0         | 0			|entrance room|
When I issue no commands
Then the game will respond with
|output|
|welcome|
||
|entrance room|

Scenario: starting the game at first room
Given that I have some rooms
| location x| location y| description	|
| 0         | 0			|entrance room|
| 0         | 1			|north room|
When I issue the commands
|command|
|north|
Then the game will respond with
|output|
|welcome|
||
|entrance room|
|You can go: north|
| '> ' |
|north room|


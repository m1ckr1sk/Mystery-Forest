Feature: Command consumption

Scenario: Quitting the game should show a farewell message

Given that the game has started
When I issue a command "quit"
Then the game will respond with
|output|
|Thanks for playing!|

Scenario: starting the game should output a greeting
Given that I have a game setup with a greeting "Welcome to the game" 
When I issue no commands
Then the game will respond with
|output|
|Welcome to the game|

Scenario: Entering a room should describe the room
Given that I have some rooms
|id| location x| location y| description	|
|1 | 0         | 0			|entrance room|
When I issue no commands
Then the game will respond with
|output|
|welcome|
||
|entrance room|

Scenario: Moving to a new room should describe new room
Given that I have some rooms
|id| location x| location y| description	|
|1 | 0         | 0			|entrance room|
|2 | 0         | 1			|north room|
When I issue the commands
|command|
|north|
Then the game will respond with exactly
|output|
|clear|
|welcome|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
||
|north room|
|You can go: south|
| '> ' |
|clear|
|Thanks for playing!|

Scenario: Moving to a new room using abbreviation should move to new room
Given that I have some rooms
|id| location x| location y| description	|
|1 | 0         | 0			|entrance room|
|2 | 0         | 1			|north room|
When I issue the commands
|command|
|n|
Then the game will respond with exactly
|output|
|clear|
|welcome|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
||
|north room|
|You can go: south|
| '> ' |
|clear|
|Thanks for playing!|

Scenario: Moving to a new room that doesn't exist should re show valid directions
Given that I have some rooms
|id| location x| location y| description	|
|1 | 0         | 0			|entrance room|
|2 | 0         | 1			|north room|
When I issue the commands
|command|
|south|
Then the game will respond with exactly
|output|
|clear|
|welcome|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
|Thanks for playing!|

Scenario: Invalid commands should re show valid directions
Given that I have some rooms
|id| location x| location y| description	|
|1 | 0         | 0			|entrance room|
|2 | 0         | 1			|north room|
When I issue the commands
|command|
|I am not a command you will know about|
Then the game will respond with exactly
|output|
|clear|
|welcome|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
||
|entrance room|
|You can go: north|
| '> ' |
|clear|
|Thanks for playing!|




Feature: Command consumption

Scenario: Quitting the game

Given that the game has started
When I issue a command "quit"
Then the game will respond with a message "Thanks for playing"

Scenario: starting the game at first room
Given that I have some rooms
| location x| location y| description	|
| 0         | 0			|"entrance room"|
When I issue no commands
Then the game will respond with
|output|
|"entrance room"|


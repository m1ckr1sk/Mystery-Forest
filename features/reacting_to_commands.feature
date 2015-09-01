Feature: Command consumption

Scenario: Quitting the game

Given that the game has started
When I issue a command "quit"
Then the game will respond with a message "Thanks for playing"


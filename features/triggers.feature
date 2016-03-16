Feature: Triggers

Scenario: Triggers should only happen once
Given that I have a welcome message "welcome"
And that I have some rooms
|id| location x | location y | description	 |
|1 | 0          | 0			 | entrance room |
|2 | 0          | 1			 | north room    |
And that I have some triggers
|room| name		| location x | location y | trigger output	 		|
|1 	 | trig_1	| 0          | 1		   | I have been triggered 	|
When I issue the commands
|command		    |
|n					|
|s					|
|n					|
Then the game will respond with exactly
|output						|
| clear |
| welcome |
| '' |
| entrance room |
| You can go: north |
| '> ' |
| clear |
| I have been triggered |
| '' |
| north room |
| You can go: south |
| '> ' |
| clear |
| '' |
| entrance room |
| You can go: north |
| '> ' |
| clear |
| '' |
| north room |
| You can go: south |
| '> ' |
| clear |
| Thanks for playing! |

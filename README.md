# MysteryForest

## Test Status

[![Circle CI](https://circleci.com/gh/m1ckr1sk/MysteryForest.svg?style=svg)](https://circleci.com/gh/m1ckr1sk/MysteryForest)

## Introduction
A text adventure in ruby

## Instructions
To run this game, using the command prompt of your choice, use the following command

    $ rake
    
or

    $ make

If you don't know how to play text adventures, I suggest you learn more before attempting to try this one.
Currently there is little instructions and help.

## Refactorings
The current form of the game has been heavily refactored using some of the SOLID principles.  The initial goals were to explicitly show the application intent through acceptance tests, build confidence in the application using unit tests and to increase comprehension through refactoring.  The majority of the refactoring has been around making the application easier to test.

Dependency inversion has been the main technique used so far to enable the application to be stimulated and inspected. 


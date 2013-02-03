# Mark Harder
# 2013.01.31
# The game engine

require_relative 'utility.rb'
require_relative 'player.rb'
require_relative 'point.rb'
require_relative 'command.rb'

include Utility

class MysteryForest
  def initialize
    # command to be performed
    @cmmnd = Command.new
  end

  # the main game loop
  def run
    clear_screen
    while @cmmnd.to_s != "quit" do
      print_room Player.current_room

      @cmmnd = get_input
      clear_screen

      perform_action @cmmnd
    end
  end

  # print the room information
  # a short description
  # the items if any
  def print_room room
    puts room.description

    unless room.items.empty? then
      puts "You see: " + room.items.collect { |item| item.name }.join(", ")
    end
  end

  # get the user input
  def get_input
    print "> "
    Command.translate gets.chomp
  end

  # perform an action based on a Command
  def perform_action command
    case command.to_s
    when "move north"
      Player.move_by Point::NORTH
    when "move south"
      Player.move_by Point::SOUTH
    when "move west"
      Player.move_by Point::WEST
    when "move east"
      Player.move_by Point::EAST
    when /^take (.*)$/
      item = command.at(1)

      if item.types.include? :item then
        Player.take_item item.value
        Player.current_room.items.delete item.value
      end
    when "inventory"
      puts "You are holding: " + Player.items.collect { |item| item.to_s }.join(", ")
    end
  end
end

game = MysteryForest.new()

game.run

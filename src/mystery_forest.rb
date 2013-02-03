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
    loop do
      print_room Player.current_room

      get_input
      clear_screen

      @cmmnd = Command.new()
      while @cmmnd.has_next? do
        perform_action @cmmnd.next
      end
    end
  end

  # print the room information
  # a short description
  # the items if any
  def print_room room
    puts room.description

    #print directions you can go
    puts "You can go: " + room.directions.join(", ")

    # print items in the room
    unless room.items.empty? then
      puts "You see: " + room.items.collect { |item| item.name }.join(", ")
    end
  end

  # get the user input
  def get_input
    print "> "
    Command.store gets.chomp
  end

  # perform an action based on a Command
  def perform_action command
    case command.to_s
    when /^move (.*)$/
      Player.move_by Point::DIRECTIONS[$1.to_sym]
    when /^take (.*)$/
      item = command.at(1)

      if item.types.include? :item then
        Player.take_item item.value
        Player.current_room.items.delete item.value
      end
    when "quit"
      puts "Thanks for playing!"
      exit
    when "inventory"
      puts "You are holding: " + Player.items.collect { |item| item.to_s }.join(", ")
    end
  end
end

game = MysteryForest.new()

game.run

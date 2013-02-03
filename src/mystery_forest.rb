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
    @cmmnd = Command.new
  end

  def run
    clear_screen
    while @cmmnd.to_s != "quit" do
      puts Player.current_room.description

      room_items = Player.current_room.items
      unless room_items.empty? then
        puts "You see: " + room_items.collect { |item| item.name }.join(", ")
      end

      print "> "
      @cmmnd = Command.translate gets.chomp
      clear_screen

      case @cmmnd.to_s
      when "move north"
        Player.move_by Point::NORTH
      when "move south"
        Player.move_by Point::SOUTH
      when "move west"
        Player.move_by Point::WEST
      when "move east"
        Player.move_by Point::EAST
      end
    end
  end
end

game = MysteryForest.new()

game.run

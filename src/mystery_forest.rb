# Mark Harder
# 2013.01.31
# The game engine

require_relative 'utility.rb'
require_relative 'player.rb'
require_relative 'point.rb'

include Utility

class MysteryForest
  def initialize
    @cmmnd = ""
  end

  def run
    clear_screen
    while @cmmnd != "quit" do
      puts Player.current_room.description
      print "> "
      @cmmnd = gets.chomp
      clear_screen

      case @cmmnd
      when "n"
        Player.move_by Point::NORTH
      when "s"
        Player.move_by Point::SOUTH
      when "w"
        Player.move_by Point::WEST
      when "e"
        Player.move_by Point::EAST
      end
    end
  end
end

game = MysteryForest.new()

game.run

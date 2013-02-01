# Mark Harder
# 2013.01.31
# The game engine

require_relative 'utility.rb'

include Utility

class MysteryForest
  def initialize
    @cmmnd = ""
  end

  def run
    clear_screen
    while @cmmnd != "quit" do
      print "> "
      @cmmnd = gets.chomp
      clear_screen
    end
  end
end

game = MysteryForest.new()

game.run

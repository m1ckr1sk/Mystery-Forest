# Mark Harder
# 2013.01.31
# The game engine

class MysteryForest
  def initialize
    @cmmnd = ""
  end

  def run
    while @cmmnd != "quit" do
      print "> "
      @cmmnd = gets.chomp
    end
  end
end

game = MysteryForest.new()

game.run

# Mark Harder
# 2013.01.31
# A singleton to hold the game world information
# - rooms

require_relative 'room.rb'
require_relative 'point.rb'

module World
  extend self

  @rooms = {
    Point.new(0, 0) => Room.new("You are standing on the south-west veranda."),
    Point.new(0, 1) => Room.new("You are standing on the north-west veranda."),
    Point.new(1, 0) => Room.new("You are standing on the south-east veranda."),
    Point.new(1, 1) => Room.new("You are standing on the north-east veranda.")
  }

  def room_at c
    @rooms[c]
  end
end


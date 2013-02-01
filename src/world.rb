# Mark Harder
# 2013.01.31
# A singleton to hold the game world information
# - rooms

require_relative 'room.rb'

module World
  extend self

  @rooms = [Room.new("You are standing in an empty room.")]

  def room_at c
    @rooms[c]
  end
end


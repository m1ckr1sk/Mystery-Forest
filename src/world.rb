# Mark Harder
# 2013.01.31
# A singleton to hold the game world information
# - rooms

require_relative 'room.rb'
require_relative 'point.rb'
require_relative 'item.rb'

require 'singleton'

class World
  include Singleton

  def initialize
    @rooms = {}

    create_room(0, 0, "You are standing on the south-west veranda.")

    create_room(0, 1, "You are standing on the north-west veranda.", [
        Item.new("Dagger", "A short, metal dagger.")
    ])
    create_room(1, 0, "You are standing on the south-east veranda.")
    create_room(1, 1, "You are standing on the north-east veranda.")
  end

  def room_at c
    @rooms[c] if @rooms
  end

  private
  def create_room x, y, descr, items=[]
    r = Room.new(descr, items)
    p = Point.new(x, y)
    opp = {
      east: :west,
      west: :east,
      south: :north,
      north: :south
    }

    for direction, point in Point::DIRECTIONS do
      if room_at(p + point) then
        r.add_direction(direction)
        room_at(p + point).add_direction(opp[direction])
      end
    end
    
    @rooms[p] = r
  end
end


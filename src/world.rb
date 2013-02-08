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

    create_room(0, 0, "The mist slowy swirls around you and curls around the trees.")

    create_room(0, 1, "You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees.", [
        Item.new("Iron Dagger", ["iron dagger", "dagger"], "A short, metal dagger.")
    ])
    create_room(1, 0, "The mist is as thick as ever, a dense, white sheet.")
    create_room(1, 1, "There must be a clearing in the trees here, you can see a halo where the sun must be shining from above.")
    create_room(2, 1, "You think you can see a faint path beneath the mist.")
    create_room(3, 1, "The mist drapes over yourself and the trees, creating a heavy blanket.")
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


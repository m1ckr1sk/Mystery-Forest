# Mark Harder
# 2013.01.31
# A singleton to hold the game world information
# - rooms

require_relative 'room.rb'
require_relative 'point.rb'
require_relative 'item.rb'
require_relative 'person.rb'

require 'singleton'

class World
  include Singleton

  def initialize
    @rooms = {}

    create_room(0, 0, "The mist slowy swirls around you and curls around the trees, lazily forming silver streams.")

    create_room(0, 1, "You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It's almost more foreboding to have tall shadows looming over you than just trees surrounded by mist.", [
      Item.new("Iron Dagger", ["iron dagger", "dagger"], "It is a short, metal dagger. The blade is flat, but sharp. The handle is plain and unadorned of any decoration except for a two circles.")
    ])
    create_room(1, 0, "The mist is as thick as ever, a dense, white sheet.")
    create_room(1, 1, "There must be a clearing in the trees here, you can see a halo where the sun must be shining from above.")
    create_room(2, 1, "You think you can see a faint path beneath the mist.")
    create_room(3, 1, "The mist drapes over yourself and the trees, creating a heavy blanket.",[],[
      Person.new("Malich", "An old man, face coated in a fine dust of gray facial hair. He is wearing a dull blue robe and staring at you, waiting for you to do something.")
    ])
    create_room(4, 0, "You can see tall shadows surrounding you. Not trees. They feel cold and hard like stone.")
    create_room(4, 1, "You can feel the firm stone beneath your feet.")
    create_room(4, 2, "The mist has thinned, you see a hole in the ground.")
    create_room(5, 1, "Now the mist has settled, twirling around your ankles. Even though you can see, all you see is inky black. You don't see any trees.")
  end

  def room_at c
    @rooms[c] if @rooms
  end

  private
  def create_room x, y, descr, items=[], people=[]
    r = Room.new(descr, items, people)
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


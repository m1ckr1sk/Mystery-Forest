require_relative 'room.rb'
require_relative 'point.rb'
require_relative 'item.rb'
require_relative 'person.rb'

class RoomList
  def initialize
    @room_map = {}
    @opp = {
          east: :west,
          west: :east,
          south: :north,
          north: :south
        }

    create_room_map(Point.new(0, 0), Room.new("The mist slowly swirls around you and curls around the trees, lazily forming silver streams.",[],[]))
    create_room_map(Point.new(0, 1), Room.new("You seem to be in an area where the layers of mist have thinned a little, the forest is marked by dull shadows of surrounding trees. It's almost more foreboding to have tall shadows looming over you than just trees surrounded by mist.", [
     Item.new("Iron Dagger", ["iron dagger", "dagger"], "It is a short, metal dagger. The blade is flat, but sharp. The handle is plain and unadorned of any decoration except for a two circles.")
   ]))
    create_room_map(Point.new(1, 0), Room.new("The mist is as thick as ever, a dense, white sheet."))
    create_room_map(Point.new(1, 1),Room.new( "There must be a clearing in the trees here, you can see a halo where the sun must be shining from above."))
    create_room_map(Point.new(2, 1), Room.new("You think you can see a faint path beneath the mist."))
    create_room_map(Point.new(3, 1), Room.new("The mist drapes over yourself and the trees, creating a heavy blanket.",[],[
      Person.new("Malich", "An old man, face coated in a fine dust of gray facial hair. He is wearing a dull blue robe and staring at you, waiting for you to do something.", Script.new)
    ]))
    create_room_map(Point.new(4, 0), Room.new("You can see tall shadows surrounding you. Not trees. They feel cold and hard like stone."))
    create_room_map(Point.new(4, 1), Room.new("You can feel the firm stone beneath your feet."))
    create_room_map(Point.new(4, 2), Room.new("The mist has thinned, you see a hole in the ground."))
    create_room_map(Point.new(5, 1), Room.new("Now the mist has settled, twirling around your ankles. Even though you can see, all you see is inky black. You don't see any trees."))
  end

  def room_at c
    @room_map[c] if @room_map
  end

  private

  def create_room_map position_point, room
    
    for direction, direction_point in Point::DIRECTIONS do
      if room_at(position_point + direction_point) then
        room.add_direction(direction)
        room_at(position_point + direction_point).add_direction(@opp[direction])
      end
    end
    @room_map[position_point] = room
  end
end
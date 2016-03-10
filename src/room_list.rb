require_relative 'room.rb'
require_relative 'point.rb'
require_relative 'item.rb'
require_relative 'person.rb'
require_relative 'location'

class RoomList
  def initialize (locations)
    @room_map = {}
    @opp = {
          east: :west,
          west: :east,
          south: :north,
          north: :south
        }

    locations.each do |location|
      create_room_map(location.point, location.room)
    end
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
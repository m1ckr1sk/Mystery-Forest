require_relative 'point'
require_relative 'room'
class Location
  attr_accessor :room, :point
  def initialize(point, room)
    @room = room
    @point = point
  end
end
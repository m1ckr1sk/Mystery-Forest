# Mark Harder
# 2013.01.31
# A singleton to hold the player information
# - location
# - inventory

require_relative 'world.rb'
require_relative 'point.rb'

module Player
  extend self

  @location = Point.new(0, 0)

  def current_room
    World.room_at @location
  end
end


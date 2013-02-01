# Mark Harder
# 2013.01.31
# A singleton to hold the player information
# - location
# - inventory

require_relative 'world.rb'

module Player
  extend self

  @location = 0

  def current_room
    World.room_at @location
  end
end


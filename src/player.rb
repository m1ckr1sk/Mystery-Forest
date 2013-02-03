# Mark Harder
# 2013.01.31
# A singleton to hold the player information
# - location
# - inventory

require_relative 'world.rb'
require_relative 'point.rb'

module Player
  attr_accessor :items

  extend self

  @location = Point.new(0, 0)
  @items = []

  def current_room
    World.instance.room_at @location
  end

  # add a point to the current player location
  def move_by point
    @location += point if World.instance.room_at(@location + point)
  end

  # put an item in the player's inventory
  def take_item item
    @items.push item
  end

  def drop_item item
    @items.delete item
  end
end


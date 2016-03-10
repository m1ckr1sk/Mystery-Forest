# Mark Harder
# 2013.01.31
# A singleton to hold the player information
# - location
# - inventory
require_relative 'point.rb'
require_relative 'environment'

class Player
  attr_accessor :location, :items

  def initialize(environment)
    @location = Point.new(0, 0)
    @items = []
    @environment = environment
  end

  def current_room
    @environment.room_at @location
  end

  def move_by point
    @location += point if @room_list.room_at(@location + point)
  end

  def put_item_into_players_inventory item
    @items.push item
  end

  def remove_item_from_players_inventory item
    @items.delete item
  end
end


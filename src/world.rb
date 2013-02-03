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

    if room_at Point.new(x + 1, y) then
      r.add_direction(:east)
      room_at(Point.new(x + 1, y)).add_direction(:west)
    end
    if room_at Point.new(x - 1, y) then
      r.add_direction(:west)
      room_at(Point.new(x - 1, y)).add_direction(:east)
    end
    if room_at Point.new(x, y + 1) then
      r.add_direction(:north)
      room_at(Point.new(x, y + 1)).add_direction(:south)
    end
    if room_at Point.new(x, y - 1) then
      r.add_direction(:south)
      room_at(Point.new(x, y - 1)).add_direction(:north)
    end
    
    @rooms[Point.new(x, y)] = r
  end
end


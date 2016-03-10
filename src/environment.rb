require_relative 'room_list.rb'

class Environment
  def initialize
    @room_list = RoomList.new
    @greeting = ''
  end

  def set_greeting(greeting)
    @greeting = greeting
  end

  def room_at coords
    @room_list.room_at coords
  end

  def greeting
    return @greeting
  end
end
require_relative 'room_list.rb'

class Environment
  def initialize
    @room_list = RoomList.new
    @greeting = "You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are."
  end
  
  def room_at coords
    @room_list.room_at coords
  end
  
  def greeting
    return @greeting
  end
end
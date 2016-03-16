require_relative 'room_list'

class Environment
  def initialize(room_list, triggers = {})
    @room_list = room_list
    @greeting = ''
    @triggers = triggers
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

  def check_triggers player
    trigger_output = ''
    @triggers.each do |trigger|
      STDOUT.puts("CHECKING TRIGGER:#{trigger}")
      if trigger[1]["triggered"] == 0 then
        if player.location == Point.new(trigger[1]["location_x"], trigger[1]["location_y"]) then
          trigger_output = trigger[1]["trigger_output"]
          trigger[1]["triggered"]  += 1
        end
      end
    end
    return trigger_output
  end
end
class HintGiver
  def initialize
    @hints = {
      moved: 0,
      talked: 0
    }
  end

  def give_hint
    if @hints[:moved] == 0 then
      return "Try typing 'move north' to walk the direction north."
    elsif @hints[:talked] == 0 then
      return "Try finding someone to talk to."
    else
      return "This is an adventure, try being adventurous"
    end
  end

  def update_hints(player, command)
    if @hints[:moved] == 0 && player_moved?(player) then
      @hints[:moved] += 1
    elsif @hints[:talked] == 0 && player_spoken_to_npc?(command) then
      @hints[:talked] += 1
    end
  end

  def player_moved?(player)
    return (player.location == Point.new(1, 0) || player.location == Point.new(0, 1))
  end

  def player_spoken_to_npc?(command)
    return command.to_s == "talk malich"
  end
end
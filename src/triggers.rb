class Triggers
  def initialize
    @triggers = {
          trip_root: 0
        }
  end

  def check_triggers player
    trigger_output = ''
    if @triggers[:trip_root] == 0 then
      if player.location == Point.new(2, 1) then
        trigger_output = "You trip over a root, grabbing out to a tree to keep your balance."
        @triggers[:trip_root] += 1
      end
    end
    return trigger_output
  end
end
# Mark Harder
# 2013.01.31
# The game engine

require_relative 'player'
require_relative 'point'
require_relative 'command'
require_relative 'command_store'
require_relative 'wrapped_screen_output'
require_relative 'stdin_input'

class MysteryForest
  def initialize(input, output)
    # command to be performed
    @cmmnd = Command.new
    @triggers = {
      trip_root: 0
    }
    @hints = {
      moved: 0,
      talked: 0
    }
    @output = output
    @input = input
    @quit_game = false
    @player = Player.new
    @command_store = CommandStore.new
  end

  # the main game loop
  def run
    @output.clear
    @output.send_output "You are walking around a park, enjoying the sunlight speckling the trees resplendent in vibrant fall colours. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the colour creeps away from your surroundings. As you begin to register the lack of colour, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognise where you are."
    while !@quit_game do
      @output.send_output ''
      print_room @player.current_room

      get_input
      @output.clear

      @cmmnd = Command.new()
      while @command_store.has_next? do
        current_command = @cmmnd.next @command_store, @player
        perform_action current_command
        perform_triggers current_command
        update_hints current_command
      end
    end
  end

  # print the room information
  # a short description
  # the items if any
  def print_room room
    @output.send_output room.description

    # print the people in the room
    unless room.people.empty? then
      @output.send_output "You see: " + room.people.collect { |person| person.name }.join(", ")
    end

    #print directions you can go
    @output.send_output "You can go: " + room.directions.join(", ")

    # print items in the room
    unless room.items.empty? then
      @output.send_output "You see: " + room.items.collect { |item| item.name }.join(", ")
    end
  end

  # get the user input
  def get_input
    @output.send_output "> "
    @command_store.store @input.get_input
  end

  # perform an action based on a Command
  def perform_action command
    case command.to_s
    when /^move (.*)$/
      @player.move_by Point::DIRECTIONS[$1.to_sym]
    when /^take (.*)$/
      item = command.at(1)

      if item.types.include?(:item) && item.types.include?(:room) then
        @output.send_output "You take the #{item.to_s}."
        @player.put_item_into_players_inventory item.value
        @player.current_room.items.delete item.value
      end
    when /^drop (.*)$/
      item = command.at(1)

      if item.types.include?(:item) && item.types.include?(:inventory) then
        @output.send_output "You drop the #{item.to_s}."
        @player.remove_item_from_players_inventory item.value
        @player.current_room.items.push item.value
      end
    when "hint"
      give_hint
    when "quit"
      @output.send_output "Thanks for playing!"
      @quit_game = true
    when /^look (.*)$/
      item = command.at(1)
      
      if item.types.include?(:item) || item.types.include?(:person) then
        @output.send_output item.value.description
      end
    when /^talk (.*)$/
      person = command.at(1)

      if person.types.include?(:person) then
        person.value.talk @input, @output
      end
    when "inventory"
    @output.send_output "You are holding: " + Player.items.collect { |item| item.to_s }.join(", ")
    end
  end

  # triggers are things that happen when a certain action is triggered
  # by an event, such as a player moving to a new room for the first time
  def perform_triggers command
    if @triggers[:trip_root] == 0 then
      if @player.location == Point.new(2, 1) then
        @output.send_output "You trip over a root, grabbing out to a tree to keep your balance."
        @triggers[:trip_root] += 1
      end
    end
  end

  # update the hints so that it can give feedback for your current
  # sitation in the game
  def update_hints command
    if @hints[:moved] == 0 && (@player.location == Point.new(1, 0) || @player.location == Point.new(0, 1)) then
      @hints[:moved] += 1
    elsif @hints[:talked] == 0 && command.to_s == "talk malich" then
      @hints[:talked] += 1
    end
  end

  # give out a hint for the player
  def give_hint
    if @hints[:moved] == 0 then
      @output.send_output "Try typing 'move north' to walk the direction north."
    elsif @hints[:talked] == 0 then
      @output.send_output "Try finding someone to talk to."
    end
  end
end

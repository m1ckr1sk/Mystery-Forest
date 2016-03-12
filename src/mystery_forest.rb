# Mark Harder
# 2013.01.31
# The game engine

require_relative 'environment'
require_relative 'player'
require_relative 'point'
require_relative 'command'
require_relative 'command_store'
require_relative 'hint_giver'
require_relative 'triggers'
require_relative 'wrapped_screen_output'
require_relative 'stdin_input'

class MysteryForest
  def initialize(input, output,environment)
    # command to be performed
    @cmmnd = Command.new
    @triggers = Triggers.new
    @hint_giver = HintGiver.new
    @output = output
    @input = input
    @quit_game = false
    @environment = environment
    @player = Player.new(@environment)
    @command_store = CommandStore.new
  end

  # the main game loop
  def run
    @output.clear
    @output.send_output @environment.greeting
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
      @output.send_output "You are holding: " + @player.items.collect { |item| item.to_s }.join(", ")
    end
  end

  # triggers are things that happen when a certain action is triggered
  # by an event, such as a player moving to a new room for the first time
  def perform_triggers
    trigger_outcome = @triggers.check_triggers(@player)
    @output.send_output trigger_outcome if trigger_outcome != ''
  end
  
  def update_hints command
     @hint_giver.update_hints(@player,command)
  end

  # give out a hint for the player
  def give_hint
    @output.send_output @hint_giver.give_hint
  end
end

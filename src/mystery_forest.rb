# Mark Harder
# 2013.01.31
# The game engine

require_relative 'environment'
require_relative 'player'
require_relative 'point'
require_relative 'command'
require_relative 'command_store'
require_relative 'hint_giver'
require_relative 'wrapped_screen_output'
require_relative 'stdin_input'

class MysteryForest
  def initialize(input, output,environment)
    @output = output
    @input = input
    @environment = environment
    
    @cmmnd = Command.new
    @hint_giver = HintGiver.new
    @command_store = CommandStore.new
    @quit_game = false
    
    @player = Player.new(@environment)
    
  end

  # the main game loop
  def run
    @output.clear
    @output.send_output @environment.greeting
    while !@quit_game do
      @output.send_output ''
      @player.current_room.print_room(@output)

      store_input_in_command_store
      @output.clear

      @cmmnd = Command.new()
      while @command_store.has_next? do
        current_command = @cmmnd.next @command_store, @player
        perform_action current_command
        perform_triggers
        update_hints current_command
      end
    end
  end

  # get the user input
  def store_input_in_command_store
    @output.send_output "> "
    @command_store.store @input.get_input
  end

  # perform an action based on a Command
  def perform_action command
    case command.to_s
    when /^move (.*)$/
      @player.move_by Point::DIRECTIONS[$1.to_sym]
    when /^take (.*)$/
      take_action command.at(1)
    when /^drop (.*)$/
      drop_action command.at(1)
    when "hint"
      give_hint
    when /^look (.*)$/
      look_action command.at(1)
    when /^talk (.*)$/
      talk_action command.at(1)
    when "inventory"
      @output.send_output "You are holding: " + @player.items.collect { |item| item.to_s }.join(", ")
    when "quit"
      @output.send_output "Thanks for playing!"
      @quit_game = true
    end
  end

  def take_action item
    if item.types.include?(:item) && item.types.include?(:room) then
      @output.send_output "You take the #{item.to_s}."
      @player.put_item_into_players_inventory item.value
      @player.current_room.items.delete item.value
    end
  end

  def drop_action item
    if item.types.include?(:item) && item.types.include?(:inventory) then
      @output.send_output "You drop the #{item.to_s}."
      @player.remove_item_from_players_inventory item.value
      @player.current_room.items.push item.value
    end
  end

  def look_action item
    if item.types.include?(:item) || item.types.include?(:person) then
      @output.send_output item.value.description
    end
  end

  def talk_action person
    if person.types.include?(:person) then
      person.value.talk @input, @output
    end
  end

  # triggers are things that happen when a certain action is triggered
  # by an event, such as a player moving to a new room for the first time
  def perform_triggers
    trigger_outcome = @environment.check_triggers(@player)
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

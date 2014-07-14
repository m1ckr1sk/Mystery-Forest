# Mark Harder
# 2013.01.31
# The game engine

require_relative 'utility.rb'
require_relative 'player.rb'
require_relative 'point.rb'
require_relative 'command.rb'

include Utility

class MysteryForest
  def initialize
    # command to be performed
    @cmmnd = Command.new
    @triggers = {
      trip_root: 0
    }
    @hints = {
      moved: 0,
      talked: 0
    }
  end

  # the main game loop
  def run
    clear_screen
    puts format_output_wrap "You are walking around a park, enjoying the sunlight speckling the trees splendent in vibrant fall colors. You breathe in the earthy air and take in the soft ground beneath you and the surrounding leaves. After strolling around for a while you don't even notice as the color creeps away from your surroundings. As you begin to register the lack of color, you see that a heavy mist has settled in, obscuring your vision. Everything is covered in a dense, white mist. You walk around, trying to find the path back to the main visitor building, but you no longer recognize where you are."
    loop do
      puts
      print_room Player.current_room

      get_input
      clear_screen

      @cmmnd = Command.new()
      while @cmmnd.has_next? do
        current_command = @cmmnd.next
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
    puts format_output_wrap room.description

    # print the people in the room
    unless room.people.empty? then
      puts "You see: " + room.people.collect { |person| person.name }.join(", ")
    end

    #print directions you can go
    puts "You can go: " + room.directions.join(", ")

    # print items in the room
    unless room.items.empty? then
      puts "You see: " + room.items.collect { |item| item.name }.join(", ")
    end
  end

  # get the user input
  def get_input
    print "> "
    Command.store $stdin.gets.chomp
  end

  # perform an action based on a Command
  def perform_action command
    case command.to_s
    when /^move (.*)$/
      Player.move_by Point::DIRECTIONS[$1.to_sym]
    when /^take (.*)$/
      item = command.at(1)

      if item.types.include?(:item) && item.types.include?(:room) then
        puts "You take the #{item.to_s}."
        Player.take_item item.value
        Player.current_room.items.delete item.value
      end
    when /^drop (.*)$/
      item = command.at(1)

      if item.types.include?(:item) && item.types.include?(:inventory) then
        puts "You drop the #{item.to_s}."
        Player.drop_item item.value
        Player.current_room.items.push item.value
      end
    when "hint"
      give_hint
    when "quit"
      puts "Thanks for playing!"
      exit
    when /^look (.*)$/
      item = command.at(1)
      
      if item.types.include?(:item) || item.types.include?(:person) then
        puts format_output_wrap item.value.description
      end
    when /^talk (.*)$/
      person = command.at(1)

      if person.types.include?(:person) then
        person.value.talk
      end
    when "inventory"
      puts "You are holding: " + Player.items.collect { |item| item.to_s }.join(", ")
    end
  end

  # triggers are things that happen when a certain action is triggered
  # by an event, such as a player moving to a new room for the first time
  def perform_triggers command
    if @triggers[:trip_root] == 0 then
      if Player.location == Point.new(2, 1) then
        puts "You trip over a root, grabbing out to a tree to keep your balance."
        @triggers[:trip_root] += 1
      end
    end
  end

  # update the hints so that it can give feedback for your current
  # sitation in the game
  def update_hints command
    if @hints[:moved] == 0 && (Player.location == Point.new(1, 0) || Player.location == Point.new(0, 1)) then
      @hints[:moved] += 1
    elsif @hints[:talked] == 0 && command.to_s == "talk malich" then
      @hints[:talked] += 1
    end
  end

  # give out a hint for the player
  def give_hint
    if @hints[:moved] == 0 then
      puts "Try typing 'move north' to walk the direction north."
    elsif @hints[:talked] == 0 then
      puts "Try finding someone to talk to."
    end
  end
end

$debug = ARGV.include?("debug")

game = MysteryForest.new()

game.run

# Mark Harder
# 2013.02.01
# Class to store user commands

class Command
  class Token
    attr_accessor :value, :types

    def initialize value, types=[:unknown]
      @value = value
      @types = types
    end

    def to_s
      @value.to_s
    end
  end

  def initialize(tokens = [])
    @tokens = tokens
  end

  def at i
    @tokens[i]
  end

  def to_s
    @tokens.join(" ")
  end

  def self.translate str
    str.downcase!

    synonyms = {
      "n" => "north",
      "s" => "south",
      "w" => "west",
      "e" => "east",
      "q" => "quit",
      "pick up" => "take",
      "get" => "take",
      "i" => "inventory"
    }

    # replace synonyms with the expected word
    for k, v in synonyms do
      str.gsub!(/\b#{k}\b/, v)
    end

    case str
    when "east"
      str = "move east"
    when "west"
      str = "move west"
    when "north"
      str = "move north"
    when "south"
      str = "move south"
    end

    verb = %w( move take quit inventory )
    direction = %w( east west south north )
    noun = %w( )
    noun += direction

    words = str.split("\s")

    # a stack to keep track of unknown words
    unknown = []
    tokens = []

    for word in words do
      types = []
      value = word

      types.push(:verb) if verb.include? word
      types.push(:noun) if noun.include? word
      types.push(:direction) if direction.include? word

      for item in Player.current_room.items do
        if item.name.downcase == word then
          types.push(:noun)
          types.push(:item)
          value = item
          break
        end
      end

      if types.empty? then
        unknown.push(word)
      else
        unknown = []
        tokens.push(Token.new(value, types));
      end
    end

    Command.new tokens
  end
end

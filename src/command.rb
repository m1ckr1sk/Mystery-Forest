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

  @@words = ""

  def initialize(tokens = [])
    @tokens = tokens
    @verb = nil
    @noun = nil
  end

  def at i
    @tokens[i]
  end

  def to_s
    @tokens.join(" ")
  end

  def has_next?
    !@@words.empty?
  end

  def next
    target = []
    first = Command.next_token

    if first.types.include? :verb then
      @verb = first

      if has_next? then
        first = Command.next_token
      end
    else
      if first.types.include? :direction then
        @verb = Token.new("move", [:verb]) if @verb.nil?
      end
    end

    target.push @verb

    if first.types.include? :verb then
      @@words.unshift(first.value)
    else
      target.push first
    end

    p target
    Command.new(target)
  end

  def self.store str
    str.downcase!

    synonyms = {
      "n" => "north",
      "s" => "south",
      "w" => "west",
      "e" => "east",
      "q" => "quit",
      "pick up" => "take",
      "get" => "take",
      "i" => "inventory",
      "and" => ""
    }

    # replace synonyms with the expected word
    for k, v in synonyms do
      str.gsub!(/\b#{k}\b/, v)
    end

    @@words = str.split(/\s+/)
  end

  private
  def self.next_token
    verb = %w( move take quit inventory )
    direction = %w( east west south north )
    noun = %w( )
    noun += direction

    # a stack to keep track of unknown words
    unknown = []

    for word in @@words do
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

      @@words.shift
      if types.empty? then
        unknown.push(word)
      else
        return Token.new(value, types)
      end
    end

    Token.new(unknown.join(" "), [:unknown])
  end

end

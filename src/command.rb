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
        @verb = Token.new("move", [:verb])
      end
    end

    target.push @verb

    if first.types.include? :verb then
      @@words.unshift(first.value) if first != @verb
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
      "look at" => "look",
      "examine" => "look",
      "x" => "look",

      "and" => "",
    }

    # replace synonyms with the expected word
    for k, v in synonyms do
      str.gsub!(/\b#{k}\b/, v)
    end

    @@words = str.split(/\s+/)
  end

  private
  def self.next_token
    possible_types = {
      verb: %w( move take quit inventory drop look ),
      direction: %w( east west south north ),
      noun: %w( )
    }

    possible_types[:noun] += possible_types[:direction]

    # a stack to keep track of unknown words
    unknown = []
    # the token returned
    token = nil

    until token do
      word = @@words.shift
      types = []
      value = word

      for type, keywords in possible_types do
        types.push(type) if keywords.include? word
      end

      for item in Player.current_room.items do
        if item.name.downcase == word then
          value = item
          types += [:noun, :item, :room]
          break
        end
      end

      for item in Player.items do
        if item.name.downcase == word then
          value = item
          types += [:noun, :item, :inventory]
          break
        end
      end

      if types.empty? then
        unknown.push(word)

        if @@words.empty? then
          token = Token.new(unknown.join(" "), [:unknwon])
        end
      else
        token = Token.new(value, types)
      end
    end

    token
  end

end

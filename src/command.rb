# Mark Harder
# 2013.02.01
# Class to store user commands

class Command
  def initialize(tokens = [])
    @tokens = tokens
  end

  def to_s
    @tokens.join(" ")
  end

  def self.translate str
    synonyms = {
      "n" => "north",
      "s" => "south",
      "w" => "west",
      "e" => "east",
      "q" => "quit"
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

    words = str.split("\s")

    # split the string on whitespace
    Command.new words
  end
end


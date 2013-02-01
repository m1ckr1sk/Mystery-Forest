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
    # split the string on whitespace
    Command.new str.split("\s")
  end
end


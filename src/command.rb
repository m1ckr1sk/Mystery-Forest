# Mark Harder
# 2013.02.01
# Class to store user commands
require_relative 'token'

class Command

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

  def next command_store, player
    target = []
    first = command_store.next_token player

    if first.types.include? :verb then
      @verb = first

      if command_store.has_next? then
        first = command_store.next_token player
      end
    else
      if first.types.include? :direction then
        @verb = Token.new("move", [:verb])
      end
    end

    target.push @verb

    if first.types.include? :verb then
      command_store.unshift(first.value) if first != @verb
    else
      target.push first
    end

    p target if $debug
    Command.new(target)
  end

  private

  
 

end

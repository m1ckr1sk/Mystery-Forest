# Mark Harder
# 2013.02.07
# Represent a person

require_relative 'script.rb'

class Person
  attr_accessor :name, :description

  def initialize name, description, script
    @name = name
    @description = description
    @script = script
  end

  def talk input, output
    @script.run(input, output, @name)
  end

  def to_s
    @name.downcase
  end
end


# Mark Harder
# 2013.02.07
# Represent a person

require_relative 'script.rb'

class Person
  attr_accessor :name, :description

  def initialize name, description
    @name = name
    @description = description
  end

  def talk input, output
    Script.run(input, output, @name)
  end

  def to_s
    @name.downcase
  end
end


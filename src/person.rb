# Mark Harder
# 2013.02.07
# Represent a person

class Person
  attr_accessor :name, :description

  def initialize name, description
    @name = name
    @description = description
    @talk = "Hi"
  end

  def talk
    puts @talk
  end
end


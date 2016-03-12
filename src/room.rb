# Mark Harder
# 2013.01.31
# A class to hold room information
# - description
# - items

class Room
  attr_accessor :description, :items, :directions, :people
  def initialize descr, items=[], people=[]
    @description = descr
    @items = items
    @people = people
    @directions = []
  end

  def add_direction dir
    @directions.push(dir)
  end

  def print_room output
    output.send_output @description

    # print the people in the room
    unless @people.empty? then
      output.send_output "You see: " + @people.collect { |person| person.name }.join(", ")
    end

    #print directions you can go
    output.send_output "You can go: " + @directions.join(", ")

    # print items in the room
    unless @items.empty? then
      output.send_output "You see: " + @items.collect { |item| item.name }.join(", ")
    end
  end
end

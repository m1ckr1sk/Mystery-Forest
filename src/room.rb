# Mark Harder
# 2013.01.31
# A class to hold room information
# - description
# - items

class Room
  attr_accessor :description, :items, :directions

  def initialize descr, items=[]
    @description = descr
    @items = items
    @directions = []
  end

  def add_direction dir
    @directions.push(dir)
  end
end

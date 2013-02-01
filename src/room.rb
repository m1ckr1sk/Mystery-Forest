# Mark Harder
# 2013.01.31
# A class to hold room information
# - description
# - items

class Room
  attr_accessor :description

  def initialize descr
    @description = descr
  end
end

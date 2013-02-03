# Mark Harder
# 2013.02.02
# A class to hold item information
# - name
# - description

class Item
  attr_accessor :name, :description

  def initialize name, description
    @name = name
    @description = description
  end

  def to_s
    name.downcase
  end
end


# Mark Harder
# 2013.02.02
# A class to hold item information
# - name
# - description

class Item
  attr_accessor :name, :description

  def initialize name, possible_names, description
    @name = name
    @possible_names = possible_names << name
    @description = description
  end

  def id_by? str
    @possible_names.include? str
  end

  def to_s
    name.downcase
  end
end


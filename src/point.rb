# Mark Harder
# 2013.01.31
# A Cartesian coordinate with x and y values

class Point
  attr_accessor :x, :y

  def initialize x, y
    @x = x
    @y = y
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  def eql? o
    @x == o.x && @y == o.y
  end

  def hash
    to_s.hash
  end
end


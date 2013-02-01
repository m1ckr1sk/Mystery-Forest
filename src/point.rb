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
    self.class.equal?(o.class) &&
      @x == o.x &&
      @y == o.y
  end

  def hash
    "(#{@x}, #{@y})".hash
  end

  alias == eql?

  NORTH = Point.new(0, 1)
  SOUTH = Point.new(0, -1)
  WEST = Point.new(-1, 0)
  EAST = Point.new(1, 0)
end


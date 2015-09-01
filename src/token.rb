class Token
  attr_accessor :value, :types
  def initialize value, types=[:unknown]
    @value = value
    @types = types
  end

  def to_s
    @value.to_s
  end
end
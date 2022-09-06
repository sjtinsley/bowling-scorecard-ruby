class Frame
attr_reader :frame_rolls

  def initialize
    @frame_rolls = []
  end

  def add_roll(pins)
    @frame_rolls << pins
  end

  def sum_pins
    @frame_rolls.sum
  end

  def first_roll_score
    @frame_rolls.first
  end
end
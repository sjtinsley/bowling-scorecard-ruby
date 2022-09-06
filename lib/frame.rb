class Frame
attr_reader :frame_rolls

  def initialize
    @frame_rolls = []
  end

  def add_roll(pins)
    @frame_rolls << pins
  end

end
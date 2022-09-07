class Game

  attr_reader :roll_index

  def initialize
    @frames = []
    @roll_index = 0
    @total_score = 0
  end

  def new_frame?
    @roll_index.even? && @roll_index < 20
  end

  def roll(pins)
    @roll_index += 1
  end
end
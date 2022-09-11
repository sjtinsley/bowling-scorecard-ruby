require './frame'

class Scorecard

  attr_reader :roll_index, :frames, :total_score

  def initialize
    @frames = []
    @roll_index = 0
  end

  def roll(pins, frame = Frame)
    if is_regular_strike?(pins)
      @frame = frame.new
      @frame.add_roll(pins)
      @frames << @frame
      @roll_index += 2
    elsif bonus_strike? && new_frame?
      @frame = frame.new
      @frame.add_roll(pins)
      @roll_index += 1
    elsif bonus_strike?
      @frame.add_roll(pins)
      @frames << @frame
    elsif bonus_spare?
      @frame = frame.new
      @frame.add_roll(pins)
      @frames << @frame
    elsif new_frame?
      @frame = frame.new
      @frame.add_roll(pins)
      @roll_index += 1
    else
      @frame.add_roll(pins)
      @frames << @frame
      @roll_index += 1
    end
    if game_finished?
      score
    end
  end

  def new_frame?
    @roll_index.even?
  end

  def game_finished?
    if @frames.length > 10
      true
    elsif @frames.length == 10 && @frames.last.sum_pins != 10
      true
    else
      false
    end
  end

  private

  def score
    @total_score = 0
    @frames.each_with_index do | frame, index |
      if frame.is_strike? && @frames[index + 1].is_strike?
        @total_score += frame.sum_pins + @frames[index + 1].sum_pins + @frames[index + 2].first_roll_score
      elsif frame.is_strike?
        @total_score += frame.sum_pins + @frames[index + 1].sum_pins
      elsif frame.is_spare?
        @total_score += frame.sum_pins + @frames[index + 1].first_roll_score
      else
        @total_score += frame.sum_pins
      end
    end
    if @frames[9].is_strike?
      @total_score -= @frames[10].sum_pins
    end
    return @total_score
  end

  def bonus_strike?
    @frames.length == 10 && @frames.last.is_strike? ? true :  false
  end

  def bonus_spare?
    @frames.length == 10 && @frames.last.is_spare? ? true :  false
  end

  def is_regular_strike?(pins)
    new_frame? && pins == 10 && @frames.length < 10 ? true : false
  end
end
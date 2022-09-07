require 'frame'

describe Frame do
  let (:frame) { Frame.new }

  describe '#add_roll' do
    it 'adds the score of the roll to the frame' do
      frame.add_roll(1)
      expect(frame.frame_rolls).to include(1)
    end
  end

  describe '#sum_pins' do
    it 'returns the sum of the pins in the frame' do
      frame.add_roll(1)
      frame.add_roll(6)
      expect(frame.sum_pins).to eq(7)
    end
  end

  describe '#first_roll_score' do
    it 'returns the first roll score of the frame' do
      frame.add_roll(2)
      frame.add_roll(5)
      expect(frame.first_roll_score).to eq(2)
    end
  end

  describe '#is_spare?' do
    it 'returns true if the frame is a spare' do
      frame.add_roll(1)
      frame.add_roll(9)
      expect(frame.is_spare?).to be true
    end

    it 'returns false if the frame is not a spare' do
      frame.add_roll(10)
      expect(frame.is_spare?).to be false
    end
  end

  describe '#is_strike?' do
    it 'returns true if the frame is a strike' do
      frame.add_roll(10)
      expect(frame.is_strike?).to be true
    end

    it 'returns false if the frame is not a strike' do
      frame.add_roll(1)
      frame.add_roll(8)
      expect(frame.is_strike?).to be false
    end
  end
end
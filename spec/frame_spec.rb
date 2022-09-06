require 'frame'

describe Frame do
  let (:frame) {Frame.new}

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
end
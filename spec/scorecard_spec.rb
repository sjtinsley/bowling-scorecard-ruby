require 'scorecard'

describe 'Scorecard' do
  let(:scorecard) { Scorecard.new }

  describe '#new_frame' do 
    it 'returns a new frame at the start of the game' do
      expect(scorecard.new_frame?).to be true
    end

    it "doesn't return a new frame after a non-strike roll" do
      scorecard.roll(8)
      expect(scorecard.new_frame?).to be false
    end

    it 'returns a new frame after a strike roll' do
      scorecard.roll(10)
      expect(scorecard.new_frame?).to be true
    end
  end

  describe '#roll' do
    it 'increases the roll index by one on a non-strike roll' do
      expect { scorecard.roll(8) }.to change { scorecard.roll_index }.by(1)
    end

    it 'increases the roll number by two on a strike roll' do
      expect { scorecard.roll(10) }.to change { scorecard.roll_index }.by(2)
    end

    it 'adds a strike frame to the frame array' do
      expect { scorecard.roll(10) }.to change { scorecard.frames.length }.by(1)
    end

    it 'does not add an incomplete frame to the frame array' do
      scorecard.roll(8)
      expect(scorecard.frames.length).to eq(0)
    end

    it 'adds a complete non-strike frame to the frame array' do
      scorecard.roll(1)
      scorecard.roll(0)
      expect(scorecard.frames.length).to eq(1)
    end

    it 'correctly scores a gutter game' do
      20.times { scorecard.roll (0) }
      expect(scorecard.total_score).to eq(0)
    end

    it 'correctly scores a perfect game' do
      12.times { scorecard.roll (10) }
      expect(scorecard.total_score).to eq(300)
    end

    it 'correctly scores a game with a mixture of strikes and non-strikes' do
      3.times { 
        scorecard.roll(8)
        scorecard.roll(1)
       }
      2.times { scorecard.roll(10) }
      5.times {
        scorecard.roll(2)
        scorecard.roll(4)
      }
      expect(scorecard.total_score).to eq(95)
    end

    it 'correctly scores a game with 10 spares' do
      10.times {
        scorecard.roll(4)
        scorecard.roll(6)
      }
      scorecard.roll(4)
      expect(scorecard.total_score).to eq(144)
    end

    it 'correctly scores a game with a mix of spare, non-spare and spares' do
      3.times {
        scorecard.roll(4)
        scorecard.roll(5)
      }
      scorecard.roll(10)
      2.times { 
        scorecard.roll(4)
        scorecard.roll(6) 
      }
      2.times {
        scorecard.roll(2)
        scorecard.roll(6)
      }
      2.times {
        scorecard.roll(10)
      }
      scorecard.roll(5)
      scorecard.roll(4)
      expect(scorecard.total_score).to eq(133)
    end
  end
end

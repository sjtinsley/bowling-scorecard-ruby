require 'game'

describe 'Game' do
  let(:game) { Game.new }

  describe '#new_frame' do 
    it 'returns a new frame at the start of the game' do
      expect(game.new_frame?).to be true
    end

    it "doesn't return a new frame after a non-strike roll" do
      game.roll(8)
      expect(game.new_frame?).to be false
    end

    it 'returns a new frame after a strike roll' do
      game.roll(10)
      expect(game.new_frame?).to be true
    end
  end

  describe '#roll' do
    it 'increases the roll index by one on a non-strike roll' do
      expect { game.roll(8) }.to change { game.roll_index }.by(1)
    end

    it 'increases the roll number by two on a strike roll' do
      expect { game.roll(10) }.to change { game.roll_index }.by(2)
    end

    it 'adds a strike frame to the frame array' do
      expect { game.roll(10) }.to change { game.frames.length }.by(1)
    end

    it 'does not add an incomplete frame to the frame array' do
      game.roll(8)
      expect(game.frames.length).to eq(0)
    end

    it 'adds a complete non-strike frame to the frame array' do
      game.roll(1)
      game.roll(0)
      expect(game.frames.length).to eq(1)
    end

    it 'correctly scores a gutter game' do
      20.times { game.roll (0) }
      expect(game.total_score).to eq(0)
    end

    it 'correctly scores a perfect game' do
      12.times { game.roll (10) }
      expect(game.total_score).to eq(300)
    end

    it 'correctly scores a game with a mixture of strikes and non-strikes' do
      3.times { 
        game.roll(8)
        game.roll(1)
       }
      2.times { game.roll(10) }
      5.times {
        game.roll(2)
        game.roll(4)
      }
      expect(game.total_score).to eq(95)
    end

    it 'correctly scores a game with 10 spares' do
      10.times {
        game.roll(4)
        game.roll(6)
      }
      game.roll(4)
      expect(game.total_score).to eq(144)
    end

    it 'correctly scores a game with a mix of spare, non-spare and spares' do
      3.times {
        game.roll(4)
        game.roll(5)
      }
      game.roll(10)
      2.times { 
        game.roll(4)
        game.roll(6) 
      }
      2.times {
        game.roll(2)
        game.roll(6)
      }
      2.times {
        game.roll(10)
      }
      game.roll(5)
      game.roll(4)
      p game.frames
      expect(game.total_score).to eq(133)
    end
  end
end

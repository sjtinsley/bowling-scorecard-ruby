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
  end

  describe '#roll' do
    it 'increases the roll index by one' do
      expect { game.roll(8) }.to change { game.roll_index }.by(1)
    end
  end
end

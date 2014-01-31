require_relative './rule'

describe Rule do
  subject(:rule) { Rule.new }
  let(:alive) { true }
  let(:dead) { false }

  describe "boundary checks" do
    it "raises an error if live_neighbours is < 0" do
      expect do
        rule.toggle?(alive, -1)
      end.to raise_error
    end

    it "raises an error if live_neighbours is > 8" do
      expect do
        rule.toggle?(alive, 9)
      end.to raise_error
    end
  end

  describe "Live cell" do
    it "toggles if less than 2 live neighbours" do
      expect(rule.toggle?(alive, 1)).to eq(true)
    end

    it "does not toggle if it has 2 or 3 live neighbours" do
      expect(rule.toggle?(alive, 2)).to eq(false)
      expect(rule.toggle?(alive, 3)).to eq(false)
    end


    it "toggles if it has more than 3 live neighbours" do
      expect(rule.toggle?(alive, 4)).to eq(true)
      expect(rule.toggle?(alive, 8)).to eq(true)
    end
  end

  describe "Dead cell" do
    it "does not toggle for 1 to 8 neigbours expect 3" do
      (1..8).each do |x|
        should_toggle = x == 3
        expect(rule.toggle?(dead, x)).to eq(should_toggle)
      end
    end
  end
end
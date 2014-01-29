require_relative './cell'

describe Cell do
  subject(:cell) { Cell.new }

  its(:alive?) { should eq(false) }

  it "can be brought to life" do
    cell.live!
    expect(cell.alive?).to be_true
  end

  it "can be killed" do
    cell.live!
    cell.die!
    expect(cell.alive?).to be_false
  end

end

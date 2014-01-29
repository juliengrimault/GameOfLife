require_relative './world'

describe World do
  let(:size) { 5 }
  let(:world) { World.new(size) }

  it "has a size" do
    expect(world.size).to eq(size)
  end

  it "can be seeded" do
    world.seed <<-eos
      *....
      .*...
      ..*..
      ...*.
      ....*
    eos

    [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]].each do |coord|
      expect(world.cell_at(coord.first, coord.last)).to be_alive
    end

    (0...size).each do |i|
      (0...size).each do |j|
        unless (i == j)
          expect(world.cell_at(i, j).alive?).to be_false
        end
      end
    end
  end

  it "can access 1 cell in the grid" do
    (0...size).each do |i|
      (0...size).each do |j|
        expect(world.cell_at(i, j).alive?).to be_false
      end
    end
  end

  it "throws when accessing a cell not in 0...size" do
    expect do
      world.cell_at(21, 21)
    end.to raise_error
  end

  describe "World ticking" do
    describe "live cell" do
      let(:test_cell) { world.cell_at(0, 0) }
      before(:each) { test_cell.live! }

      it "kills a cell if it has fewer than 2 neighbours" do
        world.tick
        expect(world.cell_at(0, 0).alive?).to be_false
      end

      describe "test_cell keep on living" do
        before(:each) do
          world.cell_at(1,1).live!
          world.cell_at(0,1).live!
        end

        it "let the cell live if it has 2 neighbours" do
          expect(world.cell_at(0, 0).alive?).to be_true
        end

        it "let the cell live if it has 3 neighbours" do
          world.cell_at(1,0).live!
          expect(world.cell_at(0, 0).alive?).to be_true
        end
      end

      it "dies if more than 3 neighbours" do
        world.seed <<-eos
        .*...
        ***..
        .*...
        .....
        .....
        eos

        world.tick
        expect(world.cell_at(1,1)).not_to be_alive
      end
    end

    describe "dead cell" do
      it "resurects if it has exactly 3 neighbours" do
        world.seed <<-eos
        .*...
        **...
        .....
        .....
        .....
        eos
        world.tick
        expect(world.cell_at(0, 0)).to be_alive
      end
    end
  end

  it "outputs the grid state" do
    map = <<-eos
*....
.*...
..*..
...*.
....*
eos
    world.seed map

    expect(world.to_ascii).to eq(map)
  end

  it "stays still" do
    patterns = []
    patterns << <<-eos
.....
.**..
.**..
.....
.....
eos
    patterns << <<-eos
.....
.**..
*..*.
.**..
.....
eos

    patterns << <<-eos
.....
.**..
*..*.
.*.*.
..*..
eos

    patterns << <<-eos
.....
.**..
.*.*.
..*..
.....
eos
    patterns.each do |p|
      world = World.new 5
      world.seed p
      world.tick
      expect(world.to_ascii).to eq(p)
    end

  end

  it "blinks" do
    world.seed <<-eos
.....
.....
.***.
.....
.....
eos

  expected = <<-eos
.....
..*..
..*..
..*..
.....
eos

    world.tick
    expect(world.to_ascii).to eq(expected)
  end

  it "follows toad pattern" do
    world = World.new 6
    world.seed <<-eos
......
......
..***.
.***..
......
......
eos

  expected = <<-eos
......
...*..
.*..*.
.*..*.
..*...
......
eos

    world.tick
    expect(world.to_ascii).to eq(expected)
  end

end

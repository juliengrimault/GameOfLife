require_relative './grid'
require_relative './cell'

describe Grid do
  let(:size) { 20 }
  let(:grid) { Grid.new(size) }

  it "can access a cell" do
    (0...size).each do |row|
      (0...size).each do |col|
        expect(grid.cell_at(row, col).class).to eq(Cell)
      end
    end
  end

  describe "neighbours" do
    it "has only 3 neighbours in the top left" do
      neighbours = grid.neighbours_at(0,0)
      expected_neighbours = [[0, 1], [1, 0], [1, 1]].map do |coord|
         grid.cell_at(coord[0], coord[1])
      end
      expect(neighbours).to eq(expected_neighbours)
    end

    it "has only 3 neighbours in the bottom right" do
      neighbours = grid.neighbours_at(size - 1, size - 1)
      expected_neighbours = [[size - 2, size - 2], [size - 2, size - 1], [size - 1, size - 2]].map do |coord|
         grid.cell_at(coord[0], coord[1])
      end
      expect(neighbours).to eq(expected_neighbours)
    end

    it "has only 3 neighbours in the bottom right" do
      neighbours = grid.neighbours_at(1, 1)
      expected_neighbours = [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]].map do |coord|
         grid.cell_at(coord[0], coord[1])
      end
      expect(neighbours).to eq(expected_neighbours)
    end
  end

  it "enumerates over each cell" do
    grid = Grid.new 2
    cells = grid.map do |cell, row, col|
      expect(cell).to eq(grid.cell_at(row, col))
      cell
    end
    expected_order = [[0, 0], [0, 1], [1, 0], [1, 1]].map { |c| grid.cell_at(c.first, c.last) }
    expect(cells).to eq(expected_order)
  end
end

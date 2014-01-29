require_relative './cell'

class Grid
  include Enumerable
  attr_reader :size

  def initialize(size)
    @size = size
    initialize_grid
  end

  def cell_at(row, col)
    @grid[row][col]
  end

  def neighbours_at(row, col)
    min_row = [0, row - 1].max
    min_col = [0, col - 1].max
    max_row = [row + 1, size - 1].min
    max_col = [col + 1, size - 1].min

    cells = []
    (min_row..max_row).each do |r|
      (min_col..max_col).each do |c|
        unless row == r and col == c
          cells.push(cell_at(r,c))
        end
      end
    end
    cells
  end

  def each &block
    (0...size).each do |row|
      (0...size).each do |col|
        block.call(cell_at(row, col), row, col)
      end
    end
  end

  private
  def initialize_grid
    @grid = []
    size.times do
      @grid.push((0...size).map do
        Cell.new
      end)
    end
  end
end
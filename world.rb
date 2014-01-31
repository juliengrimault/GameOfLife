require_relative './grid'
require_relative './rule'

class World
  DEAD = '.'
  LIVE = '*'

  attr_reader :size

  def initialize(size)
    @size = size
    @grid = Grid.new(size)
    @rule = Rule.new
  end

  def cell_at(row, col)
    @grid.cell_at(row,col)
  end

  def tick
    cells_to_toggle = @grid.map do |cell, row, col|
      process(row,col) ? cell : nil
    end.select { |c| c }

    cells_to_toggle.each { |c| c.alive? ? c.die! : c.live! }
  end

  def seed(grid_description)
    grid_description.split("\n").each_with_index do |row_string, row|
      row_string.strip.split('').each_with_index do |c, col|
        if (c == LIVE)
          cell_at(row, col).live!
        end
      end
    end
  end

  def to_ascii
    output = ""
    @grid.each do |cell, row, col|
      output += cell.alive? ? LIVE : DEAD
      if (col % size == size - 1)
        output += "\n"
      end
    end
    output
  end

  private

  def process(row, col)
    neighbours = @grid.neighbours_at(row, col)
    alive_neighbours = neighbours.select { |c| c.alive? }.count
    cell = cell_at(row, col)
    @rule.toggle?(cell.alive?, alive_neighbours)
  end
end
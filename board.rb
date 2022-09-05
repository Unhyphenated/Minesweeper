require_relative "square.rb"

class Board
    attr_reader :size, :grid
    def initialize(size=3)
        @size = size
        @grid = Array.new(size) { Array.new(size, Square.new("_")) }
        populate
        display
    end

    def populate
        num_of_bombs = rand(size * size / 2)

        num_of_bombs.times do 
            row = rand(size)
            col = rand(size)
            @grid[row][col] = Square.new("*")
        end
    end

    def display
        @grid.each { |line| puts line.join(" ") }
    end

    def adjacent_positions(pos)
        row, col = pos 
        adjacents = []

        (row - 1..row + 1).each do |new_row|
            (col - 1..col + 1).each do |new_col|
                adjacents << [new_row, new_col] if [row, col] != [new_row, new_col]
            end
        end

        adjacents
    end

    def bombs(pos)
        adjacents = adjacent_positions(pos)
        bombs = 0

        adjacents.each { |adjacent| bombs += 1 if self[adjacent].value == "*" }
           
        bombs
    end

    def [](pos)
        row, col = pos
        grid[row][col]
    end

    def []=(pos, val)
        row, col = pos
        grid[row][col] = val
    end
end

b = Board.new

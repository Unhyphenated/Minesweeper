require_relative "square.rb"

class Board
    attr_reader :size
    def initialize(size=9)
        @size = size
        @grid = Array.new(size) { Array.new(size, "_") }
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

    def adjacent_bombs(pos)
        row, col = pos 
        adjacents = []

        (row - 1..row + 1).each do |new_row|
            (col - 1..col + 1).each do |new_col|
                adjacents << [new_row, new_col] if [row, col] != [new_row, new_col]
            end
        end

        adjacents
    end
end

b = Board.new

require_relative "square.rb"

class Board
    attr_reader :size, :grid
    def initialize(size=3)
        @size = size
        @grid = Array.new(size) { Array.new(size, Square.new("_")) }
        populate
        set_values
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
            next if new_row < 0 || new_row == size
            (col - 1..col + 1).each do |new_col|
                next if new_col < 0 || new_col == size
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

    def set_values
        (0...size).each do |row|
            (0...size).each do |col|
                pos = row, col
                
                new_value = value(pos) == "*" ? "*" : bombs(pos).to_s
                switch_value(new_value, pos)
            end
        end
    end

    def value(pos)
        self[pos].value
    end

    def switch_value(new_value, pos)
        self[pos] = Square.new(new_value)
    end
end

b = Board.new

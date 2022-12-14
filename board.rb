require_relative "square.rb"

class Board
    attr_reader :size, :grid, :safe_squares
    def initialize(size)
        @size = size
        @grid = Array.new(size) { Array.new(size, Square.new("_")) }
        populate
        set_values
        @safe_squares = safe_squares
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
        system("clear")
        # puts "#{([" "] + (0...size).to_a).join(" ")}"
        # @grid.each.with_index do |line, i| 
        #     puts "#{i} #{line.join(" ")} "
        # end

        @grid.each { |line| puts line.join(" ")}
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

    def flagged?(pos)
        self[pos].flagged
    end

    def flag(pos)
        unless flagged?(pos)
            self[pos].flag
        else
            p "You cannot flag an already flagged position!"
        end
    end

    def safe_squares
        safe_squares = []
        (0...size).each do |row|
            (0...size).each do |col|
                pos = [row, col]
                if value(pos) != "*"
                    safe_squares << pos
                end
            end
        end

        safe_squares
    end

    def revealed?(pos)
        self[pos].revealed?
    end

    def reveal(pos)
        unless revealed?(pos)
            self[pos].reveal
            @safe_squares.delete(pos)
        else
            p "You cannot reveal an already revealed square!"
        end
    end

    def reveal_empty
        safe_squares.each do |safe_square|
            if value(safe_square) == "0"
                adjacents = adjacent_positions(safe_square)
                
                adjacents.each { |adjacent| self[adjacent].reveal }
            end
        end
    end

    def won?
        @safe_squares.empty?
    end

    def loss?(pos)
        value(pos) == "*"
    end

    def all_positions
        all_positions = []
        (0...size).each do |row|
            (0...size).each do |col|
                all_positions << [row, col]
            end
        end
        all_positions
    end

    def reveal_all
        all_positions.each { |square| reveal(square) }
    end
end

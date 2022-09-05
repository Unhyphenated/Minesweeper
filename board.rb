class Board
    attr_reader :size
    def initialize(size=9)
        @size = size
        @grid = Array.new(size) { Array.new(size, "_") }
        populate
        display
    end

    def populate
        num_of_bombs = rand(size * size)

        num_of_bombs.times do 
            row = rand(size)
            col = rand(size)
            @grid[row][col] = "*"
        end
    end

    def display
        @grid.each { |line| puts line.join(" ") }
    end
end

b = Board.new
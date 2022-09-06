class Minesweeper
    def initialize(size=9)
        @board = Board.new(size)

    end

    def prompt
        puts "Please enter a position you'd like to uncover (e.g., 2, 1)."
        puts "Add 'F' after the position to flag it (e.g., 2, 1, F)."
        p "> "
    end

    
end
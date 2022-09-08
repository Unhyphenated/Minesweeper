require_relative "board.rb"

class Minesweeper
    attr_reader :size, :board
    def initialize(size=9)
        @board = Board.new(size)
        @size = size
        play
    end

    def pos_prompt
        puts "Please enter a position you'd like to uncover (e.g., 2, 1)."
        print "> "
    end

    def flag_prompt
        puts "Type 'F' if you would like to flag this position."
        print "> "
    end

    def get_user_position
        pos = nil
    
        until valid_position?(pos) && pos
            pos_prompt
            pos = gets.chomp.split(",").map(&:to_i)
        end

        pos
    end

    def get_user_flag
        flag = nil

        flag_prompt

        until valid_flag?(flag) && flag
            flag = gets.chomp
        end

        flag
    end

    def valid_position?(pos)
        pos.is_a?(Array) &&
        pos.count == 2 &&
        pos.each { |ele| ele.between?(0, size) }
    end

    def valid_flag?(flag)
        flag.is_a?(String) &&
        flag.length == 1
    end

    def reveal_square(pos, flag)
        board.reveal_empty
        board.reveal(pos)
        if flag == "F"
            board.flag(pos)
        end

    end

    def gameplay_loop
        loss = false
        until loss
            board.display
            pos = get_user_position
            flag = get_user_flag

            reveal_square(pos, flag)

            if board.loss?(pos) || board.won?
                loss = true
            end
        
        end
        system("clear")
        board.display
    end

    def play
        if !board.won?
            gameplay_loop
        end

        if board.won?
            board.reveal_all
            board.display
            p "You won! Restart the program to play again."
        else
            board.reveal_all
            board.display
            p "That was a bomb! Restart the program to play again."
        end
    end
end

m = Minesweeper.new(9)
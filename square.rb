class Square
    attr_reader :value, :flagged

    def initialize(value, revealed=false)
        @value = value
        @revealed = revealed
        @flagged = false
    end

    def hide
        @revealed = false
    end

    def reveal
        @revealed = true
    end

    def revealed?
        @revealed == true 
    end

    def flag
        @flagged = true
    end
    
    def to_s
        return "F" if flagged
        return "_" if value == "0"
        @revealed ? value.to_s : "_"
    end

end
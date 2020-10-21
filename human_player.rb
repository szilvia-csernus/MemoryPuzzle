require_relative "card.rb"

class HumanPlayer

    attr_reader :name
    attr_accessor :lives, :matches_count
   
    def initialize(lives)
        @name = "Human Player"
        @lives = lives
        @matches_count = 0
    end

    def player_input(board)

        guessed_pair = []
        
        2.times do
            
            puts "Please enter the position of the card you would like to flip (e.g. '2,3')"
            print "> "
            input = gets.chomp.split(",").map(&:to_i)
            
            until (input.length == 2 && board.valid?(input) && board[input].revealed == false)
                puts "Please enter a valid input!"
                print "> "
                input = gets.chomp.split(",").map(&:to_i)
            end

            board.unseen_cards.delete(input)
            board.seen_unrevealed_cards[board[input].face_value] << input
            card_guess = board[input]
            card_guess.flip
            system("clear")
            board.print_grid
            guessed_pair << card_guess
        end
        
        guessed_pair
    end
end
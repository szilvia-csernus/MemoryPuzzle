
require "byebug"
require_relative "card.rb"

class ComputerPlayer

    attr_reader :name
    attr_accessor :lives, :matches_count

    def initialize(lives)
        @name = "Computer Player"
        @lives = lives
        @calculated_pair = []
        @matches_count = 0
    end
    
    def player_input(board)
        
        calculate_input(board)
        guessed_pair = []
        2.times do
            puts "It's the Computer Player's turn."
            print "> "
           
            if @calculated_pair.empty?
                input = board.unseen_cards.sample
                board.unseen_cards.delete(input)
                board.seen_unrevealed_cards[board[input].face_value] << input
                calculate_input(board)
            else
                if board[@calculated_pair[0]].face_up
                    input = @calculated_pair[1]
                else
                    input = @calculated_pair[0]
                end
            end
            print input
            sleep(2)
            card_guess = board[input]
            card_guess.flip
            system("clear")
            board.print_grid
            sleep(3)
            guessed_pair << card_guess
        end
        guessed_pair
    end

    def calculate_input(board)
        @calculated_pair = []
        board.seen_unrevealed_cards.each do |key, value| 
            if value.length == 2
                @calculated_pair[0] = board.seen_unrevealed_cards[key][0]
                @calculated_pair[1] = board.seen_unrevealed_cards[key][1]
            end
        end
    end

end
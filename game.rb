require_relative "card.rb"
require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"

class Game

    attr_accessor :board

    def initialize(grid_size=4)
        @board = Board.new(grid_size)
        @lives = 3
        @players = [HumanPlayer.new(@lives), ComputerPlayer.new(@lives)]
        @player = @players.first
    end

    def all_revealed?
        @board.grid.all? do |row|
            row.all? { |card| card.face_up || card.revealed }
        end
    end

    def game_over?
        all_revealed? || @players.any? { |player| player.lives == 0 }
    end

    def play

        until game_over?
            play_round
        end

        if all_revealed?
            puts "Congratulations! You resolved the puzzle!"
            puts "Winner: #{winner}"
        else
            puts "The game is over. Winner: #{winner}"
        end
    end

    def play_round

        system("clear")
        @board.print_grid

        guessed_pair = @player.player_input(@board)
        
        round_evaluate(guessed_pair)

        take_turn
        
    end

    def round_evaluate(guessed_pair)
        first, second = guessed_pair
        
        if first.face_value == second.face_value
            first.reveal
            second.reveal
            board.seen_unrevealed_cards[first.face_value] = []
            @player.matches_count += 1
            puts "It's a match!"
            sleep(5)
        else
            first.flip
            second.flip
            @player.lives -= 1
            puts "It's not a match! Player lost a life. #{@player.name}'s remaining lives: #{@player.lives}"
            sleep(5)
        end
    end

    def take_turn
        @players.rotate!
        @player = @players.first
    end

    def winner
        case @players[0].matches_count <=> @players[1].matches_count
        when 1
            winner = @players[0].name
        when -1
            winner = @players[1].name
        when 0
            winner = "Both of you!"
        end
        winner
    end

    
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end
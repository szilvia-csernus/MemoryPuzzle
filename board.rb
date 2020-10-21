require "byebug"
require "set"
require_relative 'card.rb'

class Board

    CARD_VALUES = Set.new("A".."Z")

    attr_reader :size
    attr_accessor :grid, :seen_unrevealed_cards, :unseen_cards

    def initialize(size)

        @size = size
        @grid = Array.new(size) {Array.new(size)}
        @seen_unrevealed_cards = Hash.new { |h, key| h[key] = []}
        @unseen_cards = (Array.new(@size) {|i| i}).product(Array.new(@size) { |i| i})
        populate
        
    end

    def [](position)
        row, col = position
        grid[row][col]
    end

    def []=(position, value)
        row, col = position
        grid[row][col] = value
    end

    def valid?(position)
        return false if position == nil
        row, col = position
        position.all? do |i|
            0 <= i && i < @grid.length
        end
    end

    def empty?(position)
        row, col = position
        grid[row][col] == nil
    end

    def full?
        grid.each_with_index do |row, i|
            row.each_with_index { |ele, j| return false if empty?([i, j])}
        end
        true
    end

    def populate
        indices = (0...@grid.length).to_a
        positions = indices.product(indices)
        used_cards = Set.new([])
        until full?
            card_value = (Board::CARD_VALUES - used_cards).to_a.sample
            used_cards << card_value

            2.times do 
                empty_space_found = false
                until empty_space_found
                    select_place = positions.sample
                    if empty?(select_place)
                        card = Card.new(card_value)
                        self[select_place] = card
                        positions -= select_place
                        empty_space_found = true
                    end
                end
            end
        end
    end

    def print_grid

        puts "  #{(0...@size).to_a.join(' ')}"
        @grid.each_with_index do |row, idx|
            print "#{idx}"
            row.each do |card| 
              
                if (card.face_up || card.revealed)
                    print " #{card.face_value}"
                else
                    print "  "
                end
        
            end
            puts
        end
       
    end

    
end
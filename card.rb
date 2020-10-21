class Card

    attr_reader :face_value, :seen
    attr_accessor :face_up, :revealed

    def initialize(face_value)

        @face_value = face_value
        @face_up = false
        @revealed = false
        @seen = false

    end

    def reveal
        @revealed = true
    end

    def flip
        if self.face_up == true
            self.face_up = false
        else
            self.face_up = true
        end
        @seen = true
        true
    end

   
end
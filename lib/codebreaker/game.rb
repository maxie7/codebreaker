module Codebreaker
  class Game
    attr_reader :move_number, :secret_code, :hints
    N_HINT  = 1
    N_MOVES = 12

    def initialize
      @secret_code = ""
      @hints = N_HINT
      @move_number = N_MOVES
    end

    def start
      @secret_code = generate_secret_code
      @hints = N_HINT
      @move_number = N_MOVES
    end

    def victory
      puts "Congratulations!!! YOU WIN!"
    end

    def game_over
      puts "GAME OVER! You make me lough! The secret code is #{@secret_code}"
    end

    def guess_check(player_input)
      return "number failed" unless player_input.match(/^[1-6]{4}/)
      return "the number must have 4 digits" if player_input.size != 4
      
      @move_number -= 1
      result = ""

      exact_match = @secret_code.chars.zip(player_input.chars).keep_if{|x| x.uniq.size == 1}.count
      total_match = player_input.chars.uniq.inject(0){|num, x| num += [player_input.count(x), @secret_code.count(x)].min}
      number_match = total_match - exact_match
      result = total_match == 0 ? "" : ("+" *exact_match) + ("-" *number_match)

    end

    def moves
      N_MOVES - @move_number
    end

    def hint
      return "You have used the hint already" if @hints == 0
      @hints -= 1
      x = rand(4)
      "One of the numbers in the secret code is #{@secret_code[x]}"
    end

    private

    def generate_secret_code
      (1..4).map{rand(1..6)}.join
    end
  end
end

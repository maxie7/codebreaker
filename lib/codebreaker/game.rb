module Codebreaker
  class Game
    attr_reader :move_number, :secret_code, :hints

    def initialize
      @move_number = 20
      @secret_code = ""
      @hints = 1
    end

    def start
      @secret_code = generate_secret_code
    end

    def victory
      puts "You Win!"
    end

    def game_over
      puts "Game Over! The secret code is #{@secret_code}"
    end

    def guess_check(player_input)
      input_not_eq = ""
      code_not_eq  = ""
      result       = ""

      return "number failed" unless player_input.match(/^[1-6]{4}/)
      return "the number must have 4 digits" if player_input.size != 4

      for x in 0..3
        if player_input[x] == @secret_code[x]
          result << "+"
        else
          code_not_eq << @secret_code[x]
          input_not_eq << player_input[x]
        end
      end

      input_not_eq.each_char do |x|
        if code_not_eq.include? x
          result << "-"
          code_not_eq.slice!(x)
          input_not_eq.slice!(x)
        end
      end

      @move_number -= 1
      # return victory if result == "++++"
      # return game_over if @move_number < 0
      result
    end

    def hint
      return "You have used the hint already" if @hints == 0
      @hints -= 1
      x = rand(4)
      "One of the numbers in the secret code is #{@secret_code[x]}"
    end

    private

    def generate_secret_code
      4.times{ @secret_code += "#{rand(1..6)}" }
      @secret_code
    end
  end
end

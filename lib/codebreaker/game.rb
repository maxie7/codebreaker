module Codebreaker
  class Game
    def initialize
      @move_number = 9
      @secret_code = ""
      @hint = 1
    end

    def start
      @secret_code = generate_secret_code
    end

    def guess_check(player_input)
      input_not_eq = ""
      code_not_eq  = ""
      result       = ""

      return "not a number" unless player_input.match(/^[1-6]{1,4}/)
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
      return "You Have Won!" if result == "++++"
      return "Game Over" if @move_number <= 0
      result
    end

    def hint
      return "You have used the hint already" if @hint == 0
      @hint -= 1
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

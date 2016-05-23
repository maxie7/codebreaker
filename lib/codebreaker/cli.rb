require_relative "version"
require_relative "game"
require_relative "player"
require_relative "user"

module Codebreaker
  class Cli
    def initialize
      @game = Game.new
      @player = Player.new
    end

    def play
      puts "Welcome to CodeBreaker Game! Ready to play?(y/n)"
      result = gets.chomp
      puts "'?' --to hint 'exit' --to quit"
      case result
      when /y/
        @game.start
        trigger = true
        while trigger
          puts "Enter 4-digit number:"
          answer = gets.chomp

          case answer
          when "?"
            puts @game.hint
          when /exit/
            trigger = false
          else
            if @game.move_number == 0
              puts @game.game_over
              replay_game
              trigger = false
            else
               reply = @game.guess_check(answer)
               puts reply
                 # ------------------------------------------------------
                 if reply == "++++"
                   puts @game.victory
                   replay_game
                   trigger = false
                 end
                 # --------------------------------------------------------
            end
          end
        end

      when /n/
        puts "Ok! Bye-Bye!"
      else
        puts "Unexpected error!"
      end
    end

    def save_score
      puts "Do you want to save your score?(y/n)"
      case gets.chomp
       when /y/
         puts "Please enter your name"
         name = gets.chomp
         @player.load_info
         @player.add(User.new(name: name, moves: @game.move_number))
         @player.save_info
        else
          puts "Bye-Bye!"
       end
    end

    def replay_game
      puts "Do you want to paly once again? (y/n)"
      answer = gets.chomp
      if answer == "y" ? play : save_score
    end

    end
  end

  begin_play = Cli.new
  begin_play.play
end

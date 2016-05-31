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

    def welcome_info
      puts "Welcome to CODEBREAKER GAME!"
      puts "type: '?'--to get hint 'exit'--to Quit"
    end

    def play
      welcome_info
      @game.start
      trigger = true
      while trigger
        puts "Enter 4-digit number:"
        answer = gets.chomp
        case answer
        when "?"    then puts @game.hint
        when "exit" then trigger = false
        else
          if @game.move_number == 1
            puts @game.game_over
            replay_game
            trigger = false
          else
            victory_("++++") if answer == @game.secret_code
            puts reply = @game.guess_check(answer)
            victory_(reply)
          end
        end
      end
    end

    def victory_(str_)
      return unless str_ == "++++"
      puts @game.victory
      replay_game
    end

    def save_score
      puts "Wanna save your score?(press 'y' if yes)"
      if gets.chomp == 'y'
        puts "Please enter your name"
        name = gets.chomp
        @player.load_info
        @player.add(User.new(name: name, moves: @game.moves))
        @player.save_info
        @player.create_scoring_chart
        puts "Thanks for playing, #{name}!"
      else
        puts "Bye-Bye!"
      end
      exit
    end

    def replay_game
      puts "Do you want to play once again? (press 'y' if yes)"
      gets.chomp == 'y' ? play : save_score
    end
  end

  Cli.new.play
end

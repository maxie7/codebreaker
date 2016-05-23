require 'yaml'

module Codebreaker
  class Player
    FILE = "./codebreaker/players.yaml"
    attr_accessor :players

    def initialize
      @players = []
    end

    def add(player)
      @players.push player
    end

    def create_scoring_chart
      puts "%%%%%%%%%%%%%%%%%%%%% PLAYERS' SCORES %%%%%%%%%%%%%%%%%%%%%%%%%%%"
      @players.each do |x|
        puts "Name: #{x.name}           Moves: #{x.moves}"
      end
      puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    end

    def save_info
      return "file not found" unless File.exist? FILE
      File.open(FILE, "w") do |x|
        x.write(YAML::dump(@players))
        x.close
      end
    end

    def load_info
      return "file not found" unless File.exist? FILE

      info = File.read(FILE)
      new_player = YAML::load(info)
      unless new_player.nil?
        new_player.each do |x|
          @players.push User.new(name: x.name, moves: x.moves)
        end
      end
    end

  end
end

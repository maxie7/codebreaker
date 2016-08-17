module Codebreaker
  class User < Player
    attr_accessor :name, :moves

    def initialize(name:, moves:)
      @name = name
      @moves = moves
    end
  end
end

require 'byebug'


def power(&block)
  Module.new do
    def self.included(base)
      def max_speed(speed)
        @max_speed = speed
      end

      instance_eval(&block)
    end
  end
end

Flyable = power do
  max_speed 10
end

Leapable = power do
  max_speed 6
end

Runnable = power do
  max_speed 4
end

Walkable = power do
  max_speed 1
end

class BaseHero
  include Walkable
end

class SortaFastHero < BaseHero
  include Runnable
end

class FasterHero < BaseHero
  include Leapable
end

class CuriouslySlowHero < BaseHero
  include Flyable
  include Runnable
end

class FastestHero < BaseHero
  include Flyable
end

# An imaginary game board that doesn't do anything.
class Board
  # Move a piece on the board.
  #
  # ``piece`` should be movable
  # ``actions`` is the number of consecutive actions taken to move
  #
  # Returns the total space that ``piece`` moved on the board.
  def move(piece, actions_spent)
    # Fictitious piece-moving machinery here
    actions_spent * piece.max_speed
  end
end

board = Board.new

byebug

puts

heroes = [
  ['Hero', 'Total spaces moved'],
  ['a sorta fast hero', board.move(SortaFastHero.new, 2)],
  ['a faster hero', board.move(FasterHero.new, 2)],
  ['a curiously slow hero', board.move(CuriouslySlowHero.new, 2)],
  ['the fastest hero', board.move(FastestHero.new, 2)]
]

heroes.each do |description, movement|
  printf "\t%-22s %25s\n", description, movement
end

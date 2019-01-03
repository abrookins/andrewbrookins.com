module Walkable
  def max_speed
    1 
  end
end

module Runnable
  def max_speed
    4
  end
end

module Flyable
  def max_speed
    10
  end
end

# This hero can run, which is better than nothing.
class SortaFastHero
  include Runnable
end

# This hero is confused about her powers.
class CuriouslySlowHero
  include Flyable
  include Walkable
end

# The fastest hero can fly, of course.
class FastestHero
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
    # Fake piece-moving machinery here
    actions_spent * piece.max_speed
  end
end

board = Board.new

heroes = [
  ['Hero', 'Total spaces moved'],
  ['a sorta fast hero', board.move(SortaFastHero.new, 2)],
  ['a curiously slow hero', board.move(CuriouslySlowHero.new, 2)],
  ['the fastest hero', board.move(FastestHero.new, 2)]
]

puts

heroes.each do |description, movement|
  printf "\t%-22s %25s\n", description, movement
end

Action = Struct.new('Action', :speed, :name)

module Walkable
  WALK_SPEED = 1

  def actions
    super + [
      Action.new(speed = WALK_SPEED, name = 'walk')
    ]
  end
end

module Runnable
  RUN_SPEED = 1

  def actions
    super + [
      Action.new(speed = RUN_SPEED, name = 'run')
    ]
  end
end

module Flyable
  FLY_SPEED = 10

  def actions
    super + [
      Action.new(speed = FLY_SPEED, name = 'fly')
    ]
  end
end

module Movable
  def actions
    []
  end

  def fastest_action
    actions.sort { |action| action.speed }.last
  end

  def max_speed
    fastest_action.speed
  end
end

class Hero
  include Movable
end

# This hero can run, which is better than nothing.
class SortaFastHero < Hero
  include Runnable
end

# This hero is no longer confused about her powers.
class NoLongerSlowHero < Hero
  include Flyable
  include Walkable
end

# The fastest hero can fly, of course.
class FastestHero < Hero
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
  ['a no longer slow hero', board.move(NoLongerSlowHero.new, 2)],
  ['the fastest hero', board.move(FastestHero.new, 2)]
]

puts

heroes.each do |description, movement|
  printf "\t%-22s %25s\n", description, movement
end

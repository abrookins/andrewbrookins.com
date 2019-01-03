class WalkerMixin:
    @property
    def max_speed(self):
        return 1


class RunnerMixin:
    @property
    def max_speed(self):
        return 4


class FlierMixin:
    @property
    def max_speed(self):
        return 10


class SortaFastHero(RunnerMixin):
    """This hero can run, which is better than walking."""
    pass


class CuriouslySlowHero(WalkerMixin, FlierMixin):
    """This hero is confused about her powers."""
    pass


class FastestHero(FlierMixin, RunnerMixin):
    """The fastest hero can fly, of course."""
    pass


class Board:
    """An imaginary game board that doesn't do anything."""

    def move(self, piece, actions_spent):
        """Move a piece on the board.

        ``piece`` should be movable
        ``actions`` is the number of consecutive actions taken to move

        """
        # Fictitious piece-moving machinery here
        return actions_spent * piece.max_speed


def main():
    board = Board()
    heroes = (
        ('Hero', 'Total spaces moved'),
        ('a sorta fast hero', board.move(SortaFastHero(), 2)),
        ('a curiously slow hero', board.move(CuriouslySlowHero(), 2)),
        ('the fastest hero', board.move(FastestHero(), 2))
    )
    print('\n')
    for description, movement in heroes:
        print("\t{:<22} {:>25}".format(description, movement))


if __name__ == '__main__':
    main()

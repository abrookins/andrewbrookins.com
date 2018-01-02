import collections


Action = collections.namedtuple('Action', ['speed', 'name'])


class WalkerMixin:
    WALK_SPEED = 1

    def actions(self):
        return super().actions() + [
            Action(speed=self.WALK_SPEED, name='walk')
        ]


class RunnerMixin:
    RUN_SPEED = 4

    def actions(self):
        return super().actions() + [
            Action(speed=self.RUN_SPEED, name='run')
        ]


class FlierMixin:
    FLY_SPEED = 10

    def actions(self):
        return super().actions() + [
            Action(speed=self.FLY_SPEED, name='fly')
        ]


class BaseHero:
    def actions(self):
        return []

    @property
    def fastest_action(self):
        return sorted(self.actions(), key=lambda action: action.speed,
                      reverse=True)[0]

    @property
    def max_speed(self):
        return self.fastest_action.speed


class SortaFastHero(RunnerMixin, BaseHero):
    """This hero can run, which is better than walking."""
    pass


class NoLongerSlowHero(WalkerMixin, FlierMixin, BaseHero):
    """This hero is no longer confused about her powers."""
    pass


class FastestHero(FlierMixin, RunnerMixin, BaseHero):
    """The fastest hero can fly, of course."""
    pass


class Board:
    """An imaginary game board that doesn't do anything."""
    def move(self, piece, actions_spent):
        """Move a piece on the board.

        ``piece`` should be movable
        ``actions`` is the number of consecutive actions taken to move

        Returns the total space that ``piece`` moved on the board.
        """
        return actions_spent * piece.max_speed


def main():
    board = Board()
    heroes = (
        ('Hero', 'Total spaces moved'),
        ('a sorta fast hero', board.move(SortaFastHero(), 2)),
        ('a no longer slow hero', board.move(NoLongerSlowHero(), 2)),
        ('the fastest hero', board.move(FastestHero(), 2))
    )
    print('\n')
    for description, movement in heroes:
        print("\t{:<22} {:>25}".format(description, movement))


if __name__ == '__main__':
    main()

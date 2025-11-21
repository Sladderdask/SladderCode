from random import choice

class RandomWalk():
    """A class to generate random walks."""
    def __init__(self, num_points=5000):
        """Initialize attributes of a walk."""
        self.num_points = num_points

        # All walks start at (0, 0).
        self.x_values = [0]
        self.y_values = [0]

    def fill_walk(self):
        """Calculate all the points in the walk."""

        # Keep taking steps until the walk reaches the desired length.
        while len(self.x_values) < self.num_points:
            # Decide which direction to go and how far to go in that direction.

            # Calculate the next x and y values.
            next_x = self.x_values[-1] + self.get_step()
            next_y = self.y_values[-1] + self.get_step()

            self.x_values.append(next_x)
            self.y_values.append(next_y)

    def get_step(self):
        direction = choice([-1, 1])
        distance = choice([2, 4, 5])
        return direction * distance
        





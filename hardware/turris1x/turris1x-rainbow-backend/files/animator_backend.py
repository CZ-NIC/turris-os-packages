import subprocess


class Backend:
    """Handler for all leds we can control."""

    # All available leds in order on the box
    LEDS = ["wan", "lan1", "lan2", "lan3", "lan4", "lan5", "wifi", "pwr"]

    def __init__(self):
        self.args = []

    def update(self, ledid: int, red: int, green: int, blue: int) -> None:
        """Update color of led on given index."""
        self.args.append(self.LEDS[ledid])
        self.args.append("%.2X%.2X%.2X" % red, green, blue)

    def apply(self) -> None:
        """Apply LEDs state updates."""
        self.args.insert(0, "turris1x-rainbow")
        subprocess.run(self.args, check=True)
        self.args.clear()

    @staticmethod
    def handled(ledid: int) -> bool:
        """Informs animator if given led animation should be handled by it."""
        return True  # On 1.x all leds have to be animated using animator

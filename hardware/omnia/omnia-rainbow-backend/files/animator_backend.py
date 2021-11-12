import os


class Backend:
    """Handler for all leds we can control."""

    # All available leds in order on the box
    LEDS = ["power", "lan0", "lan1", "lan2", "lan3", "lan4", "wan", "pci1", "pci2", "pci3", "user1", "user2"]

    def __init__(self):
        self._fds = tuple(os.open(f"/sys/class/leds/omnia-led:{led}/color", os.O_WRONLY) for led in self.LEDS)

    def update(self, ledid: int, red: int, green: int, blue: int) -> None:
        """Update color of led on given index."""
        os.write(self._fds[ledid], f"{red} {green} {blue}".encode())

    def apply(self) -> None:
        """Apply previous LEDs state updates if that is required."""
        # We apply immediatelly so we do not need this.

    @staticmethod
    def handled(ledid: int) -> bool:
        """Informs animator if given led animation should be handled by it."""
        return True  # On Omnia all leds have to be animated using animator
